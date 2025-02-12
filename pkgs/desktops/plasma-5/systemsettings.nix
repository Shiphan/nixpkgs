{
  mkDerivation,
  extra-cmake-modules,
  kdoctools,
  kcmutils,
  kconfig,
  kdbusaddons,
  khtml,
  ki18n,
  kiconthemes,
  kio,
  kitemviews,
  kservice,
  kwindowsystem,
  kxmlgui,
  qtquickcontrols,
  qtquickcontrols2,
  kactivities,
  kactivities-stats,
  kirigami2,
  kirigami-addons,
  kcrash,
  plasma-workspace,
}:

mkDerivation {
  pname = "systemsettings";
  nativeBuildInputs = [
    extra-cmake-modules
    kdoctools
  ];
  buildInputs = [
    kcmutils
    kconfig
    kdbusaddons
    khtml
    ki18n
    kiconthemes
    kio
    kitemviews
    kservice
    kwindowsystem
    kxmlgui
    qtquickcontrols
    qtquickcontrols2
    kactivities
    kactivities-stats
    kirigami2
    kirigami-addons
    kcrash
    plasma-workspace
  ];
  outputs = [
    "bin"
    "dev"
    "out"
  ];
  meta.mainProgram = "systemsettings5";
}
