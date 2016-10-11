#!/usr/bin/env python3

from abc import ABCMeta, abstractmethod
import glob
import os
import re
from optparse import OptionParser


class Format(metaclass=ABCMeta):
    """"An abstract test format.
    """

    @abstractmethod
    def get_name(self):
        """"Returns the name of this format."""
        pass

    @abstractmethod
    def get_source_pattern(self, task_name):
        """Returns the test file name pattern to match when converting from this
        format to a different format.
        """
        pass

    @abstractmethod
    def get_target_pattern(self, task_name):
        """Returns the test file name pattern to use when converting from
        another format to this format.
        """
        pass


class InfoarenaFormat(Format):
    """The test format used at various competitions on infoarena.ro.
    """

    def get_name(self):
        return "infoarena"

    def get_source_pattern(self, task_name):
        return r"gradertest(\d+)"

    def get_target_pattern(self, task_name):
        return r"gradertest\1"


class OniFormat(Format):
    """"The test format used at various national competitions and olympiads.
    """

    def get_name(self):
        return "oni"

    def get_source_pattern(self, task_name):
        return r"(\d+)-" + task_name

    def get_target_pattern(self, task_name):
        return r"\1-" + task_name


def get_renamed_file_path(file_path, source_pattern, target_pattern):
    """"If the name of the given file matches the source pattern, return the new
    file path in which the file name was replaced according to the target
    pattern, otherwise, return the original path.
     """
    file_name = os.path.basename(file_path)
    new_file_name = re.sub(
        r"^" + source_pattern + r"$",
        target_pattern,
        file_name)
    return os.path.join(os.path.dirname(file_path), new_file_name)


def rename_file(file_path, source_pattern, target_pattern):
    """"If the given file matches the source pattern, rename it using the target
     pattern.
     """
    new_file_path = get_renamed_file_path(
        file_path=file_path,
        source_pattern=source_pattern,
        target_pattern=target_pattern)
    if file_path != new_file_path:
        os.rename(os.path.abspath(file_path), os.path.abspath(new_file_path))


def rename_files(file_paths, source_pattern, target_pattern):
    """"Rename the given files that match the source pattern using the target
    pattern.
    """
    for file_path in file_paths:
        rename_file(file_path, source_pattern, target_pattern)


def rename_files_in_dir(
        source_pattern,
        target_pattern,
        dir_path=".",
        glob_pattern="*"):
    """"Fetch all files in the given directory that match the given glob pattern
    and rename those files which match the source pattern using the target
    pattern.
    """
    rename_files(
        file_paths=glob.iglob(os.path.join(dir_path, glob_pattern)),
        source_pattern=source_pattern,
        target_pattern=target_pattern)


def rename_tests(source_format, target_format, task_name, dir_path="."):
    """"Renames the tests from the given directory from the source format to the
    target format.
    """
    for ext in ["in", "out", "ok"]:
        source_pattern = (source_format.get_source_pattern(task_name) +
                          r"\." + ext)
        target_pattern = (target_format.get_target_pattern(task_name) +
                          r"." + ext)
        rename_files_in_dir(
            source_pattern=source_pattern,
            target_pattern=target_pattern,
            dir_path=dir_path)


def main():
    """"Registers available test formats, parses arguments and reformats the
    test names accordingly.
    """
    infoarena_format = InfoarenaFormat()
    oni_format = OniFormat()
    formats = {
        infoarena_format.get_name(): infoarena_format,
        oni_format.get_name(): oni_format
    }

    parser = OptionParser(usage="Usage: %prog [options]")
    parser.add_option(
        "-s", "--source",
        type="string",
        dest="source_format",
        help="source test format; must be one of {0}".format(formats.keys()))
    parser.add_option(
        "-t", "--target",
        type="string",
        dest="target_format",
        help="target test format; must be one of {0}".format(formats.keys()))
    parser.add_option(
        "-n", "--name",
        type="string",
        dest="task_name",
        help="the task name")
    parser.add_option(
        "-d", "--dir",
        type="string",
        dest="dir_path",
        default=".",
        help="path to tests directory")
    (options, args) = parser.parse_args()

    if not options.source_format:
        parser.error("option --source is required")
    if not options.target_format:
        parser.error("option --target is required")
    if not options.task_name:
        parser.error("option --name is required")
    if options.source_format not in formats:
        parser.error("illegal --source value: {0}; must be one of {1}"
                     .format(options.source_format, formats.keys()))
    if options.target_format not in formats:
        parser.error("illegal --target value: {0}; must be one of {1}"
                     .format(options.target_format, formats.keys()))

    rename_tests(
        formats[options.source_format],
        formats[options.target_format],
        options.task_name,
        dir_path=options.dir_path)


if __name__ == "__main__":
    main()
