from setuptools import setup, find_packages

setup(name='intel-gpu-exporter',
      version='1.0',
      # Modules to import from other scripts:
      packages=find_packages(),
      # Executables
      scripts=["intel-gpu-exporter.py"],
     )
