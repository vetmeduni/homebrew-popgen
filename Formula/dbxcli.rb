class Dbxcli < Formula
  desc "Command-line client for Dropbox"
  homepage "https://dropbox.github.io/dbxcli/"
  url "https://github.com/dropbox/dbxcli/releases/download/v3.0.0/dbxcli-darwin-amd64"
  version "3.0.0"
  sha256 "1149a2aa6a89829c6d540d04cc1db8cf5bb27e3d8b0ec6b32d830a6818bd7573"

  def install
    mv "dbxcli-darwin-amd64", "dbxcli"
    bin.install "dbxcli"
    (buildpath/"dbx-backup").write <<~EOS
      #!/bin/bash
      # Rupert Mazzucco, 2020
      version="0.1.9999"
      usage="
        Usage: $(basename $0) <source> [<dropbox folder>]

        Back up a file or folder to your Dropbox using dbxcli.
        Arguments:

        <source>         ... local file or folder
        <dropbox folder> ... Dropbox folder, must exist and be set to
                             online-only to avoid a local copy (default:
                             \\$DBX_BACKUP_ROOT if set, or '/Backup')

        Note that leading path elements are stripped, links and empty folders
        are ignored, and existing files are overwritten without warning. Dropbox
        also does not seem to like filenames with a leading '.'.
      "
      if [[ -z "$*" ]]; then
        echo "$usage"
        exit 1
      fi
      case "$1" in
        -?)        printf "%s\\n" "$usage" && exit ;;
        -h)        printf "%s\\n" "$usage" && exit ;;
        --help)    printf "%s\\n" "$usage" && exit ;;
        --version) printf "%s\\n" "$version" && exit ;;
        *)         src="$1" && shift ;;
      esac
      if [[ -z "$*" ]]; then
        tgt=${DBX_BACKUP_ROOT:-/Backup}
      else
        tgt="$1" && shift
      fi
      # upload files
      if [[ -f "$src" ]]; then
        dbxcli put "$src" "$tgt"/$(basename "$src")
      elif [[ -d "$src" ]]; then
        OLD_WD=$(pwd)
        cd $(dirname "$src")
        find $(basename "$src") -xdev -type f -exec dbxcli put "{}" "$tgt/{}" \\;
        cd "$OLD_WD"
      else
        echo "Unsupported type: $src is neither file nor folder?"
      fi
    EOS
    bin.install "dbx-backup"
  end

  test do
    system "#{bin}/dbxcli", "-h"
    system "#{bin}/dbx-backup", "--version"
  end
end
