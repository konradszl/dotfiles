{ config, pkgs, ... }:

{
  users.users.konrad = {
    name = "konrad";
    home = "/Users/konrad";
  };
}
