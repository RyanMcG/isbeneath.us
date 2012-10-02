# isbeneath.us

[isbeneath.us](http://isbeneath.us/) is a silly site I made to play with
subdomains and [sinatra](http://www.sinatra.rb/). Based on the subdomain it
looks up an image and tag line from a database and sends back a response with
the fullscreen image under the given tag line (uses `background-size: cover;`).

It's just supposed to be silly, not serious.

## TODO

*   Use an actual database (probably mongo).
*   Send back smarter headers and caching.
*   Allow user submissions.
*   Allow image upload and resizing.
