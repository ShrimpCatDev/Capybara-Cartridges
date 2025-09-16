local shader={}

shader.wave=lg.newShader("assets/shaders/trip.glsl")

shader.water=lg.newShader("assets/shaders/water.glsl")

shader.crt=lg.newShader([[
    vec4 effect(vec4 color, Image texture, vec2 tex, vec2 screen){

        vec4 pixel = Texel(texture,tex);
        vec2 center= vec2(tex.x-0.5,tex.y-0.5);

        return pixel*(color+cos(tex.y*900)/8)-sqrt(center.x*center.x+center.y*center.y)/2;
    }
]])

shader.test=lg.newShader([[
    vec4 effect(vec4 color, Image texture, vec2 tex, vec2 screen){
        vec4 pixel = Texel(texture,tex);
        return pixel;
    }
]])

shader.plasma=lg.newShader("assets/shaders/plasma.glsl")

--[[extern float time;
extern float amp;
extern float freq;
extern float spd;

vec4 effect(vec4 color, Image texture, vec2 tex, vec2 screen_coords) {
    float waveX = sin((tex.y*freq)+(time*spd))*amp;
    float waveY = cos((tex.x*freq)+(time*spd))*amp;

    vec2 dist=vec2(tex.x+waveX,tex.y+waveY);

    return Texel(texture,dist)*color+(vec4(0.5+cos((tex.y*-tex.x*8)+time*4),0.2+sin((tex.y*tex.x*8)+time*4),1,1)/4);
}]]

return shader