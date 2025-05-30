
// Miniaudio includes objc code which needs to be compiled from a .mm file
// So this just pulls in the soloud-miniaudio glue into a .mm file which makes the compiler happy
#include "../src/backend/miniaudio/soloud_miniaudio.cpp"