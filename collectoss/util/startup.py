## Startup helpers


from collectoss.application.environment import SystemEnv


def check_init_schema():
    """Initialize the CollectOSS database schema as appropriate
    """

    pass
    # does public.alembic_version exist?
        # if yes, do nothing
        # if no, do a sanity check to make sure the other schemas dont exist,
        #   then init the current db with sqlalchemy and stamp the current version with alembic

def check_update_schema():
    """ensure the CollectOSS schema is on the latest version
    """
    pass
    # alembic upgrade head, unless theres an env var preventing automatic migration
    # check_call(["alembic", "upgrade", "head"])

def collect_env_variables(logger):
    """convenience helper for assembling more complex environment variables out of smaller ones
    and other environment variable convenience operations
    """

    if SystemEnv.get("COLLECTOSS_DB") is None:
        names = ["COLLECTOSS_DB_HOST", "COLLECTOSS_DB_USER", "COLLECTOSS_DB_PASSWORD", "COLLECTOSS_DB_NAME"]
        values = [SystemEnv.get(n) for n in names]

        if all(map(lambda p: p is not None, values)):
            host, user, passwd, name = values
            SystemEnv.set("COLLECTOSS_DB", f"postgresql+psycopg2://{user}:{passwd}@{host}/{name}")
        else:
            logger.warning("CollectOSS was unable to create your database connection string automatically")
            logger.warning("The following environment variables are missing:")
            for n, v in zip(names, values):
                if v is None:
                    logger.warning(n)


    
    db_string = SystemEnv.get("COLLECTOSS_DB")
    if db_string and "localhost" in db_string:
        SystemEnv.set("COLLECTOSS_DB", db_string.replace("127.0.0.1", "host.docker.internal"))
    elif db_string and "127.0.0.1" in db_string:
        SystemEnv.set("COLLECTOSS_DB", db_string.replace("127.0.0.1", "host.docker.internal"))
