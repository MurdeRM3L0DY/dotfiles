function FindProxyForURL(url, host) {
  if (
      isPlainHostName(host) ||
      isInNet(dnsResolve(host), "127.0.0.0", "255.255.255.0")
     )
  {
    return "DIRECT";
  }

  return "PROXY 127.0.0.1:8100";
}
