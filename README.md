ETV
===

> Ethereum Transaction Verifier

This project is a simple Elixir Umbrella Application that checks if a certain Ethereum
transaction has enough "confirmations". If it does, it marks it "Complete", otherwise
it's marked "Pending".

<br />




## Setup


Following dependencies are required:

 - Erlang 20+
 - Elixir 1.6+
 - Postgres

Compile Application and Assets:

```bash
$ mix do deps.get, compile
$ mix do ecto.create, ecto.migrate
$ cd apps/etv_web/assets && npm install
```

Start the Server:

```bash
$ mix phx.server
```

<br />




## Structure

The Application is organized into 4 sub-apps, each handling a specific responsibility.
They are:



### ETV.Data

This sub-app is responsible for persisting data to the database via Ecto. It exposes a
simple API via the `Data.Transaction` module to read/write transactions. It also
handles validation of the transaction hashes, ensuring only correct values are
specified. (We could also easily replace the implementation to use a simple GenServer,
Mnesia, or another DB).

 - **Umbrella Dependencies:** None
 - **Elixir Packages:** Ecto and Helper modules



### ETV.Network

This app is responsible for connecting to external APIs to fetch information about
Ethereum Transactions, and exposes just one `ETV.Network.tx_info` method. Underneath,
it uses the API provided by `Ethplorer`, but that can be easily swapped by another
3rd-party by specifying another adapter.

You can specify a custom _API Key_ by passing a `API_KEY_ETHPLORER` environment
variable (defaults to `freekey` which has server-side rate-limits).

 - **Umbrella Dependencies:** None
 - **Elixir Packages:** HTTPoison, Jason



### ETV.Tracker

The Tracker has it's own Application Supervision Tree, which continuously checks for
unconfirmed Transactions in the DB (via the `Data` app). If there are any unconfirmed
transactions, it fetches latest information about it (via the `Network` app) and
updates their status if it has changed.

The time period currently specified is _10 seconds_, but you can change the value in
the `Tracker.AutoUpdater` module.

 - **Umbrella Dependencies:** ETV.Data, ETV.Network
 - **Elixir Packages:** None



### ETV.Web

The last one is a Phoenix application, that spawns a web-server and handles incoming
requests. It simply interacts with the `ETV.Data` app to insert new or display
existing transactions.

 - **Umbrella Dependencies:** ETV.Data
 - **Elixir Packages:** Phoenix


<br />




## Tests

The app consists of a very modest test suite. You can run them with mix:

```bash
$ MIX_ENV=test mix do ecto.create, ecto.migrate
$ mix test
```

As to not hit the actual Ethplorer Web API, Bypass is used to test against the
expected behaviour (in the ETV.Network application).

<br />



## License

The code is available as open source under the terms of the [MIT License][license].


  [license]:  https://opensource.org/licenses/MIT

