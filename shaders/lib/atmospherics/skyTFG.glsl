    #include "/lib/util/colorConversion.glsl"
    vec3 GetSky(float VdotU, float VdotS, float dither, bool doGlare, bool doGround, out bool isCustomSky, bool skipCustomSky) {
        
    vec3 daySky       = vec3(0.175, 0.28, 0.623);
    vec3 skyOrange    = vec3(1.0, 0.59, 0.35);
    vec3 nightSky     = vec3(0.04, 0.09, 0.15);
    vec3 sunColor     = vec3(1.0, 0.698, 0.5451);

    // prepare variables
    float nightFactor = smoothstep(0.1, -0.2, SdotU); 
    float VdotSClamp = VdotS * 0.5 + 0.5; // clamp from 0 to 1
    float sunHeight = max(0.0, SdotU);
    float SdotUClamp = SdotU * 0.5 + 0.5;
    float sunProximity = pow3(VdotSClamp);
          sunProximity = mix(sunProximity, 0.0, nightFactor);
    float sunProximityLin = mix(0.55, 1.0, VdotSClamp);

    // NOTES: more humidity -> more white colors, middle humidity -> red colors, low humidity -> bright yellow colors, colder -> pink-violet colors, hotter -> more red color

    // -----------   HORIZON   ------------
    // horizon position
    float horizonPos = -sqrt(max((cameraPosition.y - 100.0), 0.0)) * 0.0384; 
    float horizonGradient = clamp((VdotU - horizonPos) / (1.0 - horizonPos), 0.0, 1.0);
    float horizonFactor = 1.0 - horizonGradient;

    float horizonFactorLin = horizonFactor;
    float horizonFactorPow = pow3(horizonFactor);
    float horizonFactorPow2 = mix(0.0, horizonFactorPow, clamp(pow2(sunHeight + 0.47), 0.0, 1.0));

    float sunPathFactor = clamp((SdotU - (-0.38)) / (-0.1 - (-0.38)), 0.0, 1.0);
    float stretchedSpheroid = VdotS - (max(0.0, VdotU) * 0.85);
    float sunProximity3 = clamp((stretchedSpheroid - (-1.85)) / (1.2 - (-1.85)), 0.0, 1.0);

    float P = mix(6.0, 1.0, sunPathFactor);
    float whiteMult = pow(sunProximity3, P);
    float sunDomeMult = whiteMult * sunPathFactor;

    float globalSkyGradiet = mix(0.85, 1.0, VdotSClamp);
    float daySkyFill = pow3(sunPathFactor) * globalSkyGradiet;

    float finalWhiteMult = clamp(sunDomeMult + daySkyFill, 0.0, 1.0);

    if (SdotU >= -0.1) {
        finalWhiteMult = 1.0;
    }

    // horizon multipliars
    float whitenessFactor2 = sqrt1(clamp(sunHeight, 0.0, 1.0));
    float whitenessFactor3 = sqrt1(SdotU);


    // horizon color | factor 1 - linear
    vec3 horizonColorLin = vec3(
                                daySky.r * 1.8,
                                mix(daySky.g, daySky.b, 0.85),
                                daySky.b * 1.65
                                );
         horizonColorLin = mix(horizonColorLin, daySky, nightFactor);

    // horizon color | factor 2 - cubic
    vec3 horizonDayColorPow = vec3(
                                    mix(daySky.r, sunColor.r, horizonFactorPow),
                                    mix(daySky.g, sunColor.g, horizonFactorPow) + 0.0647 * (horizonFactorPow * (1.0 - horizonFactorPow) * 4.0),
                                    mix(daySky.b, sunColor.b, horizonFactorPow)
                                );
    vec3 horizonPowColor = mix(horizonDayColorPow, vec3(1.0), horizonFactorPow2);
         horizonPowColor = mix(horizonColorLin, horizonPowColor * 1.4, clamp(VdotSClamp + 0.7, 0.0, 1.5));

    // final sky color mixing
    vec3 finalSky = mix(daySky, horizonColorLin, horizonFactorLin);
         finalSky = mix(finalSky, horizonPowColor, horizonFactorPow);
         finalSky = mix(finalSky * sunProximityLin, finalSky, whitenessFactor3);
         finalSky = mix(nightSky, finalSky, finalWhiteMult);

    // sun and moon glare
    #if (SUN_GLARE_AMOUNT > 0 || MOON_GLARE_AMOUNT > 0)
        if (doGlare) {
            vec3 whitenessFactor = mix(vec3(1.1), vec3(0.8, 0.6, 0.7), nightFactor);
            float skyWhiteness = dot(daySky, whitenessFactor);

            float sunWhiteFactor = pow2(sunProximity * 0.34);
            finalSky = mix(finalSky, vec3(skyWhiteness) * 1.1, sunWhiteFactor);
        }
    #endif

    // apply dither
    finalSky = max(finalSky + (dither - 0.5) * 0.0078125, vec3(0.0));
    
    return finalSky;
}

// && !defined EUPHORIA_PATCHES_IS_SPACE_MOD_INSTALLED