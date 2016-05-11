# RTRlib Tools

## bgpmonParser.py

### Requirements

This tool is tested with python 2.7.11 and uses the following imports:

argparse, json, logging, multiprocessing, re, socket, string, sys, time,
xml.etree.ElementTree

Install missing dependencies with `pip`.

### Help Page
```
usage: bgpmonParser.py [-h] [-l LOGLEVEL] [-a ADDR] [-u UPORT] [-r RPORT] [-c]

Parse XML streams (updates, rib) of a BGPmon instance. Output on STDOUT as
JSON (Default) or simple CSV (less information).

optional arguments:
  -h, --help            show this help message and exit
  -l LOGLEVEL, --loglevel LOGLEVEL
                        Set loglevel [DEBUG,INFO,WARNING,ERROR,CRITICAL].
  -a ADDR, --addr ADDR  Address or name of BGPmon host (Default: localhost).
  -u UPORT, --uport UPORT
                        Port of BGPmon Update XML stream (Default: 50001).
  -r RPORT, --rport RPORT
                        Port of BGPmon RIB XML stream (Default: disabled).
  -c, --csv             Output parsed data as CSV (Default: JSON).
```
