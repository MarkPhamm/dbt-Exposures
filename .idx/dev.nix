{
  packages = with import <nixpkgs> {}; [
    python311
    python311Packages.pip
    python311Packages.setuptools
    python311Packages.wheel
    python311Packages.dbt-snowflake
  ];

  idx.extensions = [
    "ms-python.python"
  ];
}
