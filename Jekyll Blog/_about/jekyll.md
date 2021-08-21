---
icon: hardware
---
[Jekyll](https://jekyllrb.com/) is the static site generator used to build this website. Out of the box, Jekyll supports working with .csv data files. To interface with the spreadsheet, first a generator plugin calls a Google Sheets API service, it then pulls the data, and finally it writes a .csv file for each fetched sheet. After data pages have been created, Jekyll builds the site as usual, with the addition of a few extra filters.