{
  lib,
  stdenv,
  fetchgit,
  autoreconfHook,
  libgcrypt,
  pkg-config,
  curlWithGnuTls,
  gnunet,
  jansson,
  libmicrohttpd,
  libsodium,
  libtool,
  postgresql,
  taler-exchange,
  taler-merchant,
  runtimeShell,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "taler-sync";
  version = "0.13.1";

  src = fetchgit {
    url = "https://git.taler.net/sync.git";
    rev = "v${finalAttrs.version}";
    hash = "sha256-v5OQVpyTDWYGJrEbnOIDYu0nZlJcMN5AGunfn6G7s20=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    autoreconfHook
    libgcrypt
    pkg-config
  ];

  buildInputs = [
    curlWithGnuTls
    gnunet
    jansson
    libgcrypt
    libmicrohttpd
    libsodium
    libtool
    postgresql
    taler-exchange
    taler-merchant
  ];

  preFixup = ''
    substituteInPlace "$out/bin/sync-dbconfig" \
      --replace-fail "/bin/bash" "${runtimeShell}"
  '';

  meta = {
    description = "Backup and synchronization service";
    homepage = "https://git.taler.net/sync.git";
    license = lib.licenses.agpl3Plus;
    maintainers = with lib.maintainers; [ wegank ];
    platforms = lib.platforms.linux;
  };
})
