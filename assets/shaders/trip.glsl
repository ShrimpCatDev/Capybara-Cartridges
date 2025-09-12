extern float time;
extern float amp;
extern float freq;
extern float spd;

vec4 effect(vec4 color, Image texture, vec2 tex, vec2 screen_coords) {
    float waveX = sin((tex.y*freq)+(time*spd))*amp;
    float waveY = cos((tex.x*freq)+(time*spd))*amp;

    vec2 dist=vec2(tex.x+waveX,tex.y+waveY);


    return Texel(texture,dist)*color+(vec4(0.5+cos((tex.y*-tex.x*8)+time*4),0.2+sin((tex.y*tex.x*8)+time*4),1,1)/4);
}