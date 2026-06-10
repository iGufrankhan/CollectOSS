from collectoss.util.startup import collect_env_variables, check_init_schema, check_update_schema, setup_facade_directory, merge_config, warn_import_repos, print_platform_information
from collectoss.application.logs import SystemLogger
from collectoss.application.cli import DatabaseContext
import sys

if __name__ == "__main__":
    logger = SystemLogger("backend", reset_logfiles=False).get_logger()

    collect_env_variables(logger)

    check_init_schema()
    check_update_schema()

    setup_facade_directory(logger)

    merge_config(DatabaseContext().engine, logger)

    warn_import_repos(logger)

    print_platform_information(logger)

    sys.exit(0)
