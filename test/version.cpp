#include <msgpack.hpp>

#define BOOST_TEST_DONT_PRINT_LOG_VALUE
#define BOOST_TEST_MODULE version
#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_CASE(print)
{
    printf("MSGPACK_VERSION            : %s\n", MSGPACK_VERSION);
    printf("MSGPACK_VERSION_MAJOR      : %d\n", MSGPACK_VERSION_MAJOR);
    printf("MSGPACK_VERSION_MINOR      : %d\n", MSGPACK_VERSION_MINOR);
    printf("MSGPACK_VERSION_REVISION   : %d\n", MSGPACK_VERSION_REVISION);
    printf("msgpack_version()          : %s\n", msgpack_version());
    printf("msgpack_version_major()    : %d\n", msgpack_version_major());
    printf("msgpack_version_minor()    : %d\n", msgpack_version_minor());
    printf("msgpack_version_revision() : %d\n", msgpack_version_revision());
}
