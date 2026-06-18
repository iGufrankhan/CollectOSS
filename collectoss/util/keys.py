def mask_key(key: str, first: int = 6, last: int = 3, stars: int = 6) -> str:
    """Mask key except for the first and last few characters."""
    if key is None:
        return None
    if not isinstance(key, str) or len(key) <= (first + last):
        return ("*" * stars) + str(type(key))
    return f"{key[:first]}{'*' * stars}{key[-last:]}"