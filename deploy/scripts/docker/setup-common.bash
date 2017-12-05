#!/bin/bash

# This script contains code that needs to be used by more than one
# of the setup-*.bash container setup scripts in this directory.
#

##############################################################################

# Called by setup-app.bash and setup-celery.bash to add the
# mytardisdatacert app settings to the MyTardis settings.py config file.
#
# At present, each container (app and celery) has it's own copy of the
# MyTardis settings.py config file.

addMyTardisDataCertAppSettings()
{
    baseDir='/srv/mytardis'
    if cd "$baseDir"
    then
        :
    else
        echo "Can't access MyTardis base directory: $baseDir" 1>&2
        exit 1
    fi

    cat >>tardis/settings.py <<-EOF

	# Add the mytardisdatacert app and configure MyTardis to use it's post-save filter

	if 'mytardisdatacert' not in INSTALLED_APPS:
	    INSTALLED_APPS += ('tardis.apps.mytardisdatacert',)

	# Enable the MyTardis portal filter middleware (if not already done)
	#
	if not 'tardis.tardis_portal.filters.FilterInitMiddleware' in MIDDLEWARE_CLASSES:
	    MIDDLEWARE_CLASSES += ('tardis.tardis_portal.filters.FilterInitMiddleware',)
	    FILTER_MIDDLEWARE = (("tardis.tardis_portal.filters", "FilterInitMiddleware"),)

	# Add the mytardisdatacert post-save filter to the list (and create list if necessary)
	#
	if 'POST_SAVE_FILTERS' not in globals() and
	    'POST_SAVE_FILTERS' not in locals():
	        POST_SAVE_FILTERS=list()
	POST_SAVE_FILTERS += (
	    'tardis.apps.mytardisdatacert.mytardisdatacert.filters.metadata_filter.make_filter',
	    ['MyTardisDataCertMetadata', 'http://trudat.uwa.edu.au/schemas/datafile/open-format/1.0']
	    )

	# Amend the MyTardis site title to show this config has been loaded
	#
	SITE_TITLE = 'MyTardis + TruDat'
	EOF
}
