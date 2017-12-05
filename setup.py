from setuptools import setup, find_packages
import sys, os

version = '0.0.0'

setup(name='mytardisdatacert',
      version=version,
      description="TruDat Trusted Data Repository for MyTardis",
      long_description="""\
A MyTardis app to process uploaded datasets and datafiles, addding metadata \
indicating their compliance with standards and procedures.""",
      classifiers=[], # Get strings from http://pypi.python.org/pypi?%3Aaction=list_classifiers
      keywords='mytardis trusted data trudat NIF certification procedure standard',
      author='Jonathan Knispel',
      author_email='jonathan.knispel@uwa.edu.au',
      url='',
      license='MIT',
      packages=find_packages(exclude=['ez_setup', 'examples', 'tests']),
      include_package_data=True,
      zip_safe=False,
      install_requires=[
          # -*- Extra requirements: -*-
      ],
      entry_points="""
      # -*- Entry points: -*-
      """,
      )
