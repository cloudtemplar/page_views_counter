# Website View Counter

This program counts how many times each url was visited, returning both total and unique view counts.

### Running

```
$ bundle install
$ ruby website_view_counter.rb <logfile_path>
```

For the program to work, the logfile has to be in this format:
```
/help_page/1 126.318.035.038
/contact 184.123.665.067
/home 184.123.665.067
/about/2 444.701.448.104
/help_page/1 929.398.951.889
...
```
