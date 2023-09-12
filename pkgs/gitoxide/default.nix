{ 
  lib,
  rustPlatform,
  fetchFromGitHub,
  cmake,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage {
  pname = "gitoxide";
  version = "0.53.0";
  src = fetchFromGitHub {
    owner = "Byron";
    repo = "gitoxide";
    rev = "53bbd06d2b4380452d24d2c999f43b489b7446af";
    sha256 = "0kjx4zbia06br9i39h4jbm54azc72j13q5akmvyc87cki7klp3yf";
  };
  cargoHash = "sha256-gZEqm1d6F/15eWudX+pNMsESbC6JoSPAybU+E2lPbwc=";

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ openssl ];

  patches = [ ./fix-cargo-auditable.patch ];

  meta = with lib; {
    description = "An idiomatic, lean, fast & safe pure Rust implementation of Git.";
    homepage = "https://github.com/Byron/gitoxide";
  };
}
