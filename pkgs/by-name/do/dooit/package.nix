{
  lib,
  fetchFromGitHub,
  dooit,
  python311,
  testers,
  nix-update-script,
  extraPackages ? [ ],
}:
let
  python3 = python311;
in
python3.pkgs.buildPythonApplication rec {
  pname = "dooit";
  version = "3.2.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "dooit-org";
    repo = "dooit";
    tag = "v${version}";
    hash = "sha256-2W3iO4AOuDdDKJDMMY8YKXlI+dQKRI3PQtkdi9J3wZo=";
  };

  build-system = with python3.pkgs; [ poetry-core ];

  pythonRelaxDeps = [
    "tzlocal"
    "textual"
    "sqlalchemy"
  ];

  propagatedBuildInputs =
    with python3.pkgs;
    [
      pyperclip
      textual
      pyyaml
      python-dateutil
      sqlalchemy
      platformdirs
      tzlocal
      click
    ]
    ++ extraPackages;

  # /homeless-shelter
  preBuild = ''
    export HOME=$(mktemp -d)
  '';

  checkInputs = with python3.pkgs; [
    pytestCheckHook
    faker
  ];

  passthru = {
    tests.version = testers.testVersion {
      package = dooit;
      command = "HOME=$(mktemp -d) dooit --version";
    };

    updateScript = nix-update-script { };
  };

  meta = with lib; {
    description = "TUI todo manager";
    homepage = "https://github.com/dooit-org/dooit";
    changelog = "https://github.com/dooit-org/dooit/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [
      khaneliman
      wesleyjrz
      kraanzu
    ];
    mainProgram = "dooit";
  };
}
