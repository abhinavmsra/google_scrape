# README

**Introduction**

**Google Scraper** is an application that accepts a list of keywords , scrapes the Google Search Page for the words and stores the various metrics of the corresponding page.

The application employs the Distributed Architecture of Heroku as a coping mechanism from getting black listed by Google. A single Heroku app has various services running on multiple instances having different public IP. 

The application runs a main app and enqueues the scraping task in the Redis Server. Similarly, the same app is deployed on multiple other Heroku instances running Sidekiq workers, each pointing to same Redis server. Now as the scraping task in enqueued in Redis by the main app, the Sidekiq workers pick up the task and perform it. This way we accomplish the task by scraping the page from multiple IP addresses. 

A constraint worth noticing here is the database connection pool size. The application uses Postgres database as it has larger connection pool on Heroku free tier than MySQL. The application can be scaled by adding the number of Sidekiq workers. However, reducing the concurrency of individual workers is advised as to reduce the suspicion arising from scraping multiple keywords at once from the same machine.

**Running the App Locally**

1. Clone the project from the Git:

`git clone git@github.com:abhinavmsra/google_scrape.git`

2. Run `bundle install` to install gem dependencies.

3. Create and migrate the database.

4. Run the Rails Server and Sidekiq.

**Current Resources**

1. Main App: https://g-s.herokuapp.com
2. Workers: 4

    a. https://gs-w1.herokuapp.com
    
    b. https://gs-w4.herokuapp.com
    
    c. https://powerful-chamber-15630.herokuapp.com
    
    d. https://protected-basin-76701.herokuapp.com
    
3. Concurrency of individual workers: 4


