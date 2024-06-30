import 'package:signalr_netcore/signalr_client.dart';

void main(List<String> arguments) async {
  const JWT_TOKEN =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjU4IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6MTcxOTcxNTkyNH0.B8KGr5mj4z3QZpx5sv8k_dusPs2xcf8gnE7xRddC-LQ";

  const serverUrl = "https://bidup.runasp.net/appHub";
// Creates the connection by using the HubConnectionBuilder.
  final httpConnectionOptions = HttpConnectionOptions(
    accessTokenFactory: () => Future.value(JWT_TOKEN),
    logMessageContent: true,
  );

  final hubConnection = HubConnectionBuilder()
      .withUrl(serverUrl, options: httpConnectionOptions)
      .build();

  await hubConnection.start();

  hubConnection.invoke("JoinAuctionsFeedRoom", args: null);
  hubConnection.on("AuctionCreated", (arguments) => print(arguments));
  hubConnection.on("AuctionDeletedOrEnded", (arguments) => print(arguments));
  hubConnection.on("AuctionPriceUpdated", (arguments) => print(arguments));
  hubConnection.on("BidCreated", (arguments) => print(arguments));
  hubConnection.on("BidAccepted", (arguments) => print(arguments));
  hubConnection.on("ErrorOccurred", (arguments) => print(arguments));

  hubConnection.onclose(
    ({error}) => print("Connection Closed"),
  );
}
