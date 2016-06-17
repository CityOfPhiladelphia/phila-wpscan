# Phila WPScan

This repo can be used to deploy an AWS EC2 instance that uses [WPScan](http://wpscan.org/) to monitor WordPress installations for known vulnerabilities.

## Additional details

During installation, `wpscan.sh` is added to the crontab. When `wpscan.sh` completes, it publishes the results of the scan to an AWS SNS Topic. Subscribers/recipients can be managed from the AWS Console.

## Launching a new instance

1. [Install joia](https://github.com/CityOfPhiladelphia/joia/)
1. Clone this repository
1. Add the `.env` file to the root directory of your local copy of the repository
1. Add a `wpscan-targets.txt` file to the root directory of your local copy of the repository
1. Open a terminal window and navigate to the `phila-wpscan` repository
1. Run `joia up`

## Example wpscan-targets.txt

List the urls of the sites you'd like to scan, each on their own line.

```
https://example.com
https://example.com
```
