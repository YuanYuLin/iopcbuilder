class Singleton:
    INSTANCE = None

    def __new__(class_type):
        if not Singleton.INSTANCE:
            Singleton.INSTANCE = object.__new__(class_type)
            print "Singleton super"
        else:
            print "Already exist"

        return Singleton.INSTANCE
    
