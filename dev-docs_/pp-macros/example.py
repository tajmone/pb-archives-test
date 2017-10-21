"""
Python code taken from Evennia.

https://github.com/evennia/evennia/blob/master/evennia/commands/cmdset.py

Evennia MU* creation system 
Copyright (c) 2012-, Griatch (griatch <AT> gmail <DOT> com), Gregory Taylor 
All rights reserved.

BSD 3-clause "New" or "Revised" License

"""
from future.utils import listvalues, with_metaclass

from weakref import WeakKeyDictionary
from django.utils.translation import ugettext as _
from evennia.utils.utils import inherits_from, is_iter
__all__ = ("CmdSet",)


class _CmdSetMeta(type):
    """
    This metaclass makes some minor on-the-fly convenience fixes to
    the cmdset class.
    """
    def __init__(cls, *args, **kwargs):
        """
        Fixes some things in the cmdclass
        """
        # by default we key the cmdset the same as the
        # name of its class.
        if not hasattr(cls, 'key') or not cls.key:
            cls.key = cls.__name__
        cls.path = "%s.%s" % (cls.__module__, cls.__name__)

        if not type(cls.key_mergetypes) == dict:
            cls.key_mergetypes = {}

        super(_CmdSetMeta, cls).__init__(*args, **kwargs)
