![logo](logo.png)

Google Music Uploader - Docker Image
====================================

[![Docker Pulls](https://img.shields.io/docker/pulls/jaymoulin/google-music-uploader.svg)](https://hub.docker.com/r/jaymoulin/google-music-uploader/)
[![Docker stars](https://img.shields.io/docker/stars/jaymoulin/google-music-uploader.svg)](https://hub.docker.com/r/jaymoulin/google-music-uploader/)
[![Bitcoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/btc.png "Bitcoin donation")](https://m.freewallet.org/id/374ad82e/btc)
[![Litecoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ltc.png "Litecoin donation")](https://m.freewallet.org/id/374ad82e/ltc)
[![PayPal donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ppl.png "PayPal donation")](https://www.paypal.me/jaymoulin)
[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png "Buy me a coffee")](https://www.buymeacoffee.com/3Yu8ajd7W)

This image allows you to watch a folder and upload all new MP3 added to your Google Music Library.
This image is based on [Google MusicManager](https://github.com/jaymoulin/google-music-manager)

Installation
---

```
docker run -d --restart=always -v /path/to/your/library:/media/library --name googlemusic jaymoulin/google-music-uploader
```

You must define your path to your library in a volume to `/media/library`
You can also mount another volume to `/root/oauth` folder to retrieve your oauth key 

See environment variables to tweak some behaviour

Environment variables
---------------------

These environment variable will produce a different behaviour

* `REMOVE` : Remove file on successful upload (boolean, (default: false)) - pass to true if you want to remove files 
* `ONESHOT` : Execute only once without listening to folder events (boolean, (default: false)) - pass to true if you want to execute only once (also remove `--restart=always` from docker parameters) 
* `UPLOADER_ID` : Identity of your uploader, must be your MAC address in uppercase 
    (default: false, which means your actual MAC address) - Change this value only if you know what you are doing and had `MAX_PER_MACHINE_USERS_EXCEEDED` error
* `DEDUP_API` : Url to the deduplicate API (string (default: None)) - Will call deduplicate API before trying to sample and upload to Google Music
* `LOGIN` : Login (for cover art uploading) (string (default: None)) - Login of your Google Music account for cover art uploading
* `PASSWORD` : Password (for cover art uploading) (string (default: None)) - Password of your Google Music account for cover art uploading

### Example
```
docker run -d --restart=always -v /path/to/your/library:/media/library --name googlemusic -e REMOVE=true jaymoulin/google-music-uploader
```
will delete files on upload

Deduplicate
-----------

You can (un)mark files as duplicate thanks to the deduplicate API included.
For example, if you already know all your library was already uploaded to Google Music, you can mark all files as already uploaded in the deduplicate api.

```
docker exec googlemusic google-music-upload-deduplicate --deduplicate_api http://172.17.0.1 -d /media/library
```

Consult [Google Music Manager Uploader Deduplicate](https://github.com/jaymoulin/google-music-manager-uploader#deduplicate) for further informations.

Configuration
---
First, you have to allow the container to access your Google Music account
```
docker exec -ti googlemusic auth
```
Then follow prompted instructions.

You will be asked to go to a Google URL to allow the connection:

```
Visit the following url:
 https://accounts.google.com/o/oauth2/v2/auth?client_id=XXXXXXXXXXX.apps.googleusercontent.com&access_type=offline&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fmusicmanager&response_type=code&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob
Follow the prompts, then paste the auth code here and hit enter:
```

Once done, restart the container to start watching your folder and uploading your MP3.
```
docker restart googlemusic
```

Appendixes
---

### Install Docker

If you don't have Docker installed yet, you can do it easily in one line using this command
 
```
curl -sSL "https://gist.githubusercontent.com/jaymoulin/e749a189511cd965f45919f2f99e45f3/raw/0e650b38fde684c4ac534b254099d6d5543375f1/ARM%2520(Raspberry%2520PI)%2520Docker%2520Install" | sudo sh && sudo usermod -aG docker $USER
```


