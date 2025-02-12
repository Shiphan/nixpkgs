{
  lib,
  python3,
  fetchPypi,
  mailman,
  nixosTests,
}:

with python3.pkgs;
buildPythonPackage rec {
  pname = "mailman-hyperkitty";
  version = "1.2.1";
  format = "setuptools";

  disabled = pythonOlder "3.9";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-+Nad+8bMtYKJbUCpppRXqhB1zdbvvFXTTHlwJLQLzDg=";
  };

  propagatedBuildInputs = [
    mailman
    requests
    zope-interface
  ];

  nativeCheckInputs = [
    mock
    nose2
  ];

  checkPhase = ''
    ${python.interpreter} -m nose2 -v
  '';

  # There is an AssertionError
  doCheck = false;

  pythonImportsCheck = [
    "mailman_hyperkitty"
  ];

  passthru.tests = { inherit (nixosTests) mailman; };

  meta = with lib; {
    description = "Mailman archiver plugin for HyperKitty";
    homepage = "https://gitlab.com/mailman/mailman-hyperkitty";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ qyliss ];
  };
}
