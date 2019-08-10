# trebekbot

A Jeopardy! bot for Slack, powered by the [jService](http://jservice.io/) API. Sets up a perpetual game of Jeorpardy! in your Slack channels.

This *slightly* modified version of the original [trebekbot](https://github.com/gesteves/trebekbot) simply provides updated instructions for setting up and hosting the trebekbot manually (without Heroku, since Heroku's free tier sleeps after 30 minutes of inactivity). This configuration utilizes Docker, so hosting is up to the user.

## Requirements
* Admin access in Slack
* An AWS/Google Cloud/Azure account (or any other service that will host a Docker container)

## Slack Setup
1. Set up a Slack outgoing webhook at https://slack.com/services/new/outgoing-webhook.
    * Set the channel for your Jeopardy fun (#jeopardy is a good choice)
    * The trigger word(s) should be "trebekbot, tb" (without quotes)
    * Under the URLs, add the URL or IP address of your host (if you do not know this, you can come back to this step later)
    * Customize the label, name, and icon as you wish
    * Make note of the Token, as you will need this later for your Outgoing Webhook Token
2. Go to https://api.slack.com/apps and create a new app
    * Make sure you create the app in the correct workspace, as this cannot be changed
    * From the Basic Information Section of the app, click on "Add features and functionality" and then click on "Bots"
    * Create a new bot with a Display name and Default username of "trebekbot"
    * Go back to Basic Information and click on "Install your app to your workspace", and install the app into your workspace
    * Once the app has been installed, go back to the application's page and open up the "OAuth & Permissions" section
    * Make note of the "Bot User OAuth Access Token", as you will need this later for your Slack API Token

## Deployment Setup
1. Create a virtual machine using whatever service you have chosen
    * You may choose any operating system you are comfortable with, as long as it is capable of running Docker
    * You must make sure that your virtual machine has a public IP address, and that port 80 is open to the public
2. Once the virtual machine has been created, log in and install Docker
    * This will vary by operating system, so you should consult Docker's [installation guide](https://docs.docker.com/install/)
    * (I personally recommend using the package manager for your operating system)
3. Clone this repository to your virtual machine, and cd to it once it has cloned
4. Duplicate the `.env.example` file in the trebekbot folder, and name the copy `.env`
5. Fill in the following information in the `.env` file
    * `LOCAL_REDIS_URL=redis://localhost:6379`
    * `OUTGOING_WEBHOOK_TOKEN=the token from step 1 of the Slack setup`
    * `BOT_USERNAME=trebekbot`
    * `API_TOKEN=the token from step 2 of the Slack setup`
    * `SIMILARITY_THRESHOLD=0.5`
    * `SECONDS_TO_ANSWER=30`
    * `CHANNEL_BLACKLIST=general (plus any other blacklisted channels, separated by commas)`
    * `QUESTION_SUBSTRING_BLACKLIST=1`
    * Delete the line starting with `REDISCLOUD_URL`
6. Run the following commands to create the Docker image, and create a container from that image
    * `docker build -t trebekbot .`
        * Creates a docker image called trebekbot
    * `docker create -t -i -p 80:80 --name tb trebekbot`
        * Creates a container named tb from the trebekbot image you just created.
        * Port 80 in the container is mapped to port 80 on the virtual machine, so all requests to port 80 on the host will be forwarded to the container
    * `docker start tb`
        * Start the container you just created
7. Go to your slack channel and type "tb jeopardy me" and enjoy Jeopardy
    * tb must be a valid hook that you configured in step 1 of the Slack setup