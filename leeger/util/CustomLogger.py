from __future__ import annotations

import logging
import sys


class CustomFormatter(logging.Formatter):
    """
    Simple custom formatter to replace the sleeper dependency.
    """
    def __init__(self, fmt: str, datefmt: str):
        super().__init__(fmt=fmt, datefmt=datefmt)


class CustomLogger:
    @staticmethod
    def getLogger() -> logging.Logger:
        # set up logging
        # https://docs.python.org/3/howto/logging.html
        logger = logging.getLogger("root")
        logger.setLevel(logging.INFO)
        if not logger.hasHandlers():
            # set up handler
            handler = logging.StreamHandler()
            handler.setLevel(logging.INFO)
            handler.setStream(sys.stdout)
            # set up formatter
            formatter = CustomFormatter(
                "%(asctime)-8s %(levelname)-8s %(message)s", "%Y-%m-%d %H:%M:%S"
            )
            # set in each other
            handler.setFormatter(formatter)
            logger.addHandler(handler)
        return logger
