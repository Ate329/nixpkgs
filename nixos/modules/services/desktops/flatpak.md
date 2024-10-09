# Flatpak {#module-services-flatpak}

*Source:* {file}`modules/services/desktop/flatpak.nix`
*Upstream documentation:* <https://github.com/flatpak/flatpak/wiki>

Flatpak is a system for building, distributing, and running sandboxed desktop
applications on Linux.

To enable Flatpak, add the following to your {file}`configuration.nix`:

```nix
{
  services.flatpak.enable = true;
}
```

For the sandboxed apps to work correctly, desktop integration portals need to
be installed. If you run GNOME, this will be handled automatically for you;
in other cases, you will need to add something like the following to your
{file}`configuration.nix`:

```nix
{
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";
}
```

## Declarative Package Management

NixOS now supports declarative management of Flatpak packages. You can specify
Flatpak packages to be installed, updated, or removed in your 
{file}`configuration.nix`:

```nix
{
  services.flatpak = {
    enable = true;
    packages = [ "org.blender.Blender" "net.ankiweb.Anki" ];
    removeUnmanagedPackages = true;
  };
}
```

This configuration will:
- Enable Flatpak
- Install or update the specified packages (Blender and Anki in this example)
- Remove any Flatpak packages not listed in the `packages` option

The `removeUnmanagedPackages` option is optional and defaults to `false`.

## Manual Package Management

If you prefer to manage Flatpak packages manually, you can still do so.

First, you will need to add a repository, for example,
[Flathub](https://github.com/flatpak/flatpak/wiki),
either using the following commands:

```ShellSession
$ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
$ flatpak update
```

or by opening the
[repository file](https://flathub.org/repo/flathub.flatpakrepo) in GNOME Software.

Then, you can search and install programs:

```ShellSession
$ flatpak search bustle
$ flatpak install flathub org.freedesktop.Bustle
$ flatpak run org.freedesktop.Bustle
```

GNOME Software offers a graphical interface for these tasks.

Note: When using declarative package management, manually installed packages
may be removed if `removeUnmanagedPackages` is set to `true` and the package
is not listed in the `packages` option.
