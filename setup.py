"""Pip configuration."""
from setuptools import setup

with open("README.md", "r") as fh:
    long_description = fh.read()

setup(
    name="urlbuster",
    version="0.5.1",
    description="URL bruteforcer to locate existing and/or hidden files or directories.",
    license="MIT",
    long_description=long_description,
    long_description_content_type="text/markdown",
    author="cytopia",
    author_email="cytopia@everythingcli.org",
    url="https://github.com/cytopia/urlbuster",
    install_requires=["requests"],
    scripts=[
        "bin/urlbuster"
    ],
    data_files=[
        ("share/urlbuster/examples", [
            "examples/useragents-basic.txt",
            "examples/useragents-sqlinject.txt"
        ])
    ],
    classifiers=[
        # https://pypi.org/classifiers/
        #
        'Development Status :: 5 - Production/Stable',
        # Indicate who your project is intended for
        "Intended Audience :: Developers",
        "Intended Audience :: Information Technology",
        "Intended Audience :: Science/Research",
        "Intended Audience :: System Administrators",
        # Project topics
        "Topic :: Internet",
        "Topic :: Security",
        "Topic :: System :: Systems Administration",
        "Topic :: Utilities",
        # License
        "License :: OSI Approved :: MIT License",
        # Specify the Python versions you support here. In particular, ensure
        # that you indicate whether you support Python 2, Python 3 or both.
        "Programming Language :: Python",
        "Programming Language :: Python :: 2",
        "Programming Language :: Python :: 3",
        # How does it run
        "Environment :: Console",
        # Where does it rnu
        "Operating System :: OS Independent",
    ],
 )
