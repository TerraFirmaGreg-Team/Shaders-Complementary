// TFGEDITS
// this file is included at the end of /lib/common.glsl so it can override any user settings

// disable clouds
#ifndef WORLD_MARS //we dont have any planets we keep clouds, so i put whatever
    #undef VL_CLOUDS_ACTIVE
    #undef CLOUD_SHADOWS
#endif

#define HAS_NO_MOON //ad astra handles astral object, no need on the shader side

#ifdef AD_ASTRA_ORBIT
	
	#define UNLIT_SKY_OBJECTS //Sun doesnt fade when over the horizon
	
	#define CELESTIAL_BOTH_HEMISPHERES //Stars still appear below the horizon
	
    #define DAYLIGHT_STARS //stars appear at day
    #define HAS_NO_ATMOSPHERE
	#undef	BORDER_FOG
#endif

#ifdef WORLD_EUROPA
    #define DAYLIGHT_STARS
    #undef  LENSFLARE
    #undef  BLOOM_FOG
	#undef	BORDER_FOG
    #ifdef SWITCH_PLANET_WINDSPEED
        #define PLANET_WIND_MULTIPLIER 0.04
    #endif
#endif

#ifdef WORLD_MARS
    #define SUN_SIZE 100 //normal is 400
	#undef	BORDER_FOG
    #ifdef SWITCH_PLANET_WINDSPEED
        #define PLANET_WIND_MULTIPLIER 0.3
    #endif
#endif

#ifdef WORLD_MERCURY
    #define SUN_SIZE 2000 //normal is 400
    #define DAYLIGHT_STARS
    #define HAS_NO_ATMOSPHERE
#endif

#ifdef WORLD_MOON
    #define DAYLIGHT_STARS
    #define HAS_NO_ATMOSPHERE
	#undef	BORDER_FOG
	#define HAS_NO_ATMOSPHERE
    #define BLOOM_STRENGTH 0.03 //[0 to 10]
#endif

#ifdef HAS_NO_ATMOSPHERE
    #undef LIGHTSHAFTS_ACTIVE
    #define LIGHTSHAFT_BEHAVIOUR 0
    #define rainFactor 0
    #define invRainFactor 1
    #define PLANET_WIND_MULTIPLIER 0
#endif