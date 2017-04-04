module DefinedError
  module ErrorCode
    #user
    ERR_USER_NAME_CANNOT_BE_BLANK                                     = 10001
    ERR_USER_NAME_THE_MAXIMUM_LENGTH_OF_32                    = 10002
    ERR_USER_PASSWORD_CANNOT_BE_BLANK                             = 10003
    ERR_USER_PASSWORD_THE_MAXIMUM_LENGTH_OF_64            = 10004
    ERR_USER_NICKNAME_CANNOT_BE_BLANK                               = 10005
    ERR_USER_NICKNAME_THE_MAXIMUM_LENGTH_OF_32              = 10006
    ERR_USER_NAME_NOT_UNIQUE                                                 = 10007
    ERR_USER_NICKNAME_NOT_UNIQUE                                          = 10008

    #category
    ERR_CATEGORY_NAME_CANNOT_BE_BLANK                             = 11001
    ERR_CATEGORY_SEQ_CANNOT_BE_BLANK                                = 11002
    ERR_CATEGORY_NAME_THE_MAXIMUM_LENGTH_OF_32            = 11003
    ERR_CATEGORY_NAME_NOT_UNIQUE                                        = 11004

    #tag
    ERR_TAG_NAME_CANNOT_BE_BLANK                               = 12001
    ERR_TAG_NAME_THE_MAXIMUM_LENGTH_OF_32              = 12002
    ERR_TAG_NAME_NOT_UNIQUE                                         = 12003
  end
end
