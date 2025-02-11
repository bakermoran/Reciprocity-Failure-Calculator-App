# Reciprocity failure calculator

When shooting photos on photographic film in low light, the amount of sensitivity a film stock has degrades over time as the film continues to be exposed. When taking pictures at night for example, this can become a problem. Exposing photos according to a light meter will lead to underexposed photos. Thankfully however, this is a [well understood problem](<https://en.wikipedia.org/wiki/Reciprocity_(photography)?useskin=vector>).

Film manufacturers publish the "reciprocity factory", which allows us to calculate proper exposure times given a reading from a light meter. Different film stocks can have very different factors however, so this app functions as a database as much as a calculator.

## Examples

[Ilford](https://www.ilfordphoto.com/wp/wp-content/uploads/2024/05/Reciprocity-Failure-Compensation-v2.pdf) lists the factor for HP5+ at `1.31`. This means a meter reading of 10 seconds would give us roughly a `20 second` exposure time to properly expose the image. Delta 400 however with a factor of `1.41` would give an exposure time of `26 seconds`, or roughly a third of a stop difference.

```
Exposed_time = Metered_time ^ factor
```

### References

[Ilford](https://www.ilfordphoto.com/wp/wp-content/uploads/2024/05/Reciprocity-Failure-Compensation-v2.pdf)
[Kodak](https://125px.com/docs/techpubs/kodak/e31-2002_07.pdf)
