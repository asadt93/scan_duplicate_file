# Simple scan duplicate file

> Simple code to scan duplicate file content

## Version

---

- ruby 2.6.6

## How it works

---

##### print result content + number

&nbsp;
this code is responsible to getting the result of content file + number of duplications

```sh

ruby simple_scan_file.rb '/path/to/check/'

abcdef - 4



```

##### print result by grouping duplicate file content

&nbsp;
this code is responsible to getting the result file by returning file name list group by number of duplications

```sh

ruby scan_file.rb '/path/to/check/'

========= found 2 duplicate content ============
1) - 4 duplicate files
-- ./A/content2
-- ./B/D/content3
-- ./B/content1
-- ./content1
2) - 3 duplicate files
-- ./pdf_test (3rd copy).pdf
-- ./pdf_test (another copy).pdf
-- ./pdf_test.pdf


execution time :    115 ms
total file     :    12


```
