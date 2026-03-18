// this file is included at the end of /lib/common.glsl so it can override any user settings

// disable clouds
#ifndef WORLD_whatever
    #undef VL_CLOUDS_ACTIVE
#endif

#ifdef AD_ASTRA_ORBIT
    #define HAS_NO_MOON
    #define HAS_NO_ATMOSPHERE
    // Keep all bloom and lens flare effects for sun
    // #undef  LENSFLARE
    // #undef  BLOOM_FOG
	
	//Sun doesnt fade when on the horizon
	#define UNLIT_SKY_OBJECTS
	#define CELESTIAL_BOTH_HEMISPHERES
    #define NEBULA_AT_DAY
    #define DAYLIGHT_STARS
    #undef  ATM_FOG_MULT
    #define ATM_FOG_MULT 0.0
    #undef  LIGHTSHAFTS_ACTIVE
    #define LIGHTSHAFTS_ACTIVE 0
    #undef  LIGHTSHAFT_BEHAVIOUR
    #define LIGHTSHAFT_BEHAVIOUR 0
#endif

#ifdef WORLD_EUROPA
    #define HAS_NO_MOON
    #define DAYLIGHT_STARS
    #undef  LENSFLARE
    #undef  BLOOM_FOG
	#undef	BORDER_FOG
#endif
#ifdef WORLD_MOON
    #define HAS_NO_MOON
    #define NEBULA_AT_DAY
    #define DAYLIGHT_STARS
    #define HAS_NO_ATMOSPHERE
	#undef	BORDER_FOG
    #undef  ATM_FOG_MULT
    #define ATM_FOG_MULT 0.0
    #undef  LIGHTSHAFTS_ACTIVE
    #define LIGHTSHAFTS_ACTIVE 0
    #undef  LIGHTSHAFT_BEHAVIOUR
    #define LIGHTSHAFT_BEHAVIOUR 0
#endif

#ifdef WORLD_MERCURY
    #define HAS_NO_MOON
    #define NEBULA_AT_DAY
    #define DAYLIGHT_STARS
	
#endif

#ifdef WORLD_MARS
    #define HAS_NO_MOON
    #undef  ATM_FOG_MULT
    #define ATM_FOG_MULT 0.0
    #undef  LIGHTSHAFTS_ACTIVE
    #define LIGHTSHAFTS_ACTIVE 1
    #undef  LIGHTSHAFT_BEHAVIOUR
    #define LIGHTSHAFT_BEHAVIOUR 1
	#undef	BORDER_FOG
#endif

#ifdef HAS_NO_ATMOSPHERE
    #undef LIGHTSHAFTS_ACTIVE
    #define LIGHTSHAFT_BEHAVIOUR 0
    #define rainFactor 0
    #define invRainFactor 1
#endif