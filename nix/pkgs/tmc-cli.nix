{ lib
, stdenvNoCC
, fetchurl
, makeWrapper
, jdk21
, maven
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tmc-cli";
  version = "0.9.3";

  src = fetchurl {
    url = "https://github.com/testmycode/tmc-cli/releases/download/${finalAttrs.version}/tmc-cli-${finalAttrs.version}.jar";
    hash = "sha256-Cx1KAdNgNI24miCPw6Z1NcvkrIXxdHB4LJHMt88E3b4=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/tmc-cli
    cp $src $out/share/tmc-cli/tmc-cli.jar

    makeWrapper ${jdk21}/bin/java $out/bin/tmc \
      --add-flags "--add-opens java.base/java.lang=ALL-UNNAMED" \
      --add-flags "-jar $out/share/tmc-cli/tmc-cli.jar --no-update" \
      --prefix PATH : ${lib.makeBinPath [ jdk21 maven ]}

    runHook postInstall
  '';

  meta = {
    description = "Command-line client for the TestMyCode (TMC) service used by mooc.fi courses";
    homepage = "https://github.com/testmycode/tmc-cli";
    license = lib.licenses.mit;
    mainProgram = "tmc";
    platforms = lib.platforms.unix;
  };
})
