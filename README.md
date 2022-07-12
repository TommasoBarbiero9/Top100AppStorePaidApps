# Top100AppStorePaidApps

        Started: planning the app’s structure (following MVC pattern), opted for the storyboard usage, 
        collected basic knowledge of UIKit components, started creating the basic interface keeping in mind
        what kind of data it’s needed to show: name, image, summary, price and id.
        Decided to opt for the same design the App Store has and use it as reference.
        The accent color is the one I assume is the company’s main one.


API Endpoint used:
https://itunes.apple.com/us/rss/toppaidapplications/limit=200/json

NOTES:
-Couldn’t use the newest swift’s concurrency (async/await) because of the task assigned (it was asked to deploy an app for iOS 12)
-Want to point out the API Endpoint actually shows only 99 entries even though the url says 200

FUTURE IMPLEMENTATIONS:
-Category filter
