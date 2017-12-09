"""
"/3-python-intermediate/examples/solution2.py" (CC0 1.0 Universal)
Python example by Yevgen Runts, taken from:
-- https://github.com/yrunts/python-for-qa
"""
import os
import csv
import re
from tempfile import NamedTemporaryFile
import shutil

from dateutil import parser, tz


NGINX_LINE_REGEXP = re.compile(
    ('(?P<ipaddress>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})'
     ' - - '
     '\[(?P<dateandtime>\d{2}\/[a-z]{3}\/\d{4}:\d{2}:\d{2}:\d{2} (\+|\-)\d{4})\] '
     '((\"(?P<method>GET|POST|CONNECT|HEAD) )'
     '(?P<url>.+)(http\/1\.(1|0)")) '
     '(?P<statuscode>\d{3}) '
     '(?P<bytessent>\d+) '
     '(["](?P<refferer>(\-)|(.+))["]) '
     '(["](?P<useragent>.+)["])'), re.IGNORECASE)
DATE_FORMAT = '%d/%m/%y'
TIME_FORMAT = '%H:%M:%S'
FIELDS = ['ip', 'date', 'time', 'method', 'url', 'status_code']


def main():

    storage = NamedTemporaryFile()
    writer = csv.DictWriter(storage, FIELDS)

    with open('../logs.txt') as f:
        for line in f.readlines():
            match = re.match(NGINX_LINE_REGEXP, line)

            if not match:
                continue

            log_datetime = match.group('dateandtime').replace(':', ' ', 1)
            log_datetime = parser.parse(log_datetime)
            utc_log_datetime = log_datetime.astimezone(tz.tzutc())

            parsed_item = {'ip': match.group('ipaddress'),
                           'date': utc_log_datetime.strftime(DATE_FORMAT),
                           'time': utc_log_datetime.strftime(TIME_FORMAT),
                           'method': match.group('method'),
                           'url': match.group('url'),
                           'status_code': match.group('statuscode')}
            writer.writerow(parsed_item)

    shutil.copy(storage.name, os.path.join(os.getcwd(), 'logs.csv'))
    storage.close()


if __name__ == '__main__':
    main()
