extern float time;

vec4 effect(vec4 color, Image texture, vec2 tex, vec2 scn) {

    vec2 c1=vec2(tex.x-0.5,tex.y-0.5);
    float plasma1 = cos(sqrt(c1.x*c1.x+c1.y*c1.y)*25+time);
    vec2 c2=vec2(tex.x+0.5,tex.y+0.5);
    float plasma2 = cos(sqrt(c2.x*c2.x+c2.y*c2.y)*50-time);
    vec2 c3=vec2(tex.x,tex.y+1);
    float plasma3 = cos(sqrt(c3.x*c3.x+c3.y*c3.y)*100+time);
    vec2 c4=vec2(tex.x+1,tex.y+1);
    float plasma4 = cos(sqrt(sqrt(c4.x*c4.x+c4.y*c4.y))*175-time);

    float col=plasma1+plasma2+plasma3+plasma4/2;
    return vec4(col-.8,col-.5,col+.2,1);
}