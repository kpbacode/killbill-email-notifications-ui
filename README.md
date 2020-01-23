# killbill-email-notifications-ui
Rails mountable engine to configure the email notifications plugin

* See [killbill-email-notifications-plugin](https://github.com/killbill/killbill-email-notifications-plugin) to get started with the email notification plugin.
* See [killbill-admin-ui-standalone](https://github.com/killbill/killbill-admin-ui-standalone) to get started with the Kill Bill Admin UI.

Kill Bill compatibility
-----------------------

| Kenui version | Kill Bill version |
| ------------: | ----------------: |
| 0.1.x         | 0.18.z            |
| 1.x.y         | 0.20.z            |
| 2.x.y         | 0.22.z            |

Getting Started
---------------

You can run this locally by using the test/dummy app provided.

To do so, specify your Kill Bill server url, api key and secret in ```test/dummy/config/initializers/killbill_client.rb```:

```
KillBillClient.url = 'http://127.0.0.1:8080/'
KillBillClient.api_key = 'bob'
KillBillClient.api_secret = 'lazar'
```

Then, simply run:

```
rails s
```


To run tests:

```
rails t
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
