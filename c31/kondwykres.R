x <- c(0.025,
       0.033,
       0.041,
       0.049,
       0.057,
       0.065,
       0.073,
       0.081,
       0.089,
       0.097)

vsr <- c(9.88,
         9.026666667,
         8.52,
         7.9,
         7.226666667,
         6.443333333,
         5.666666667,
         4.653333333,
         3.443333333,
         1.933333333)
vt <- c(10,
        7.997310352,
        6.431520926,
        5.145731728,
        4.054830878,
        3.107441884,
        2.270158154,
        1.520030934,
        0.840613794,
        0.219716738)

plot(x, vsr, type="p", col="blue", pch=16,
     ylim=c(min(c(vsr, vt)), max(c(vsr, vt))),
     xlab="Odległość x [m]", ylab="Potencjał V",
     main="Zależność potencjału V od odległości x")

# Dodanie linii vt

lines(x, vt, type="l", col="red", pch=17)
# Dodanie legendy
legend("topright", legend=c("Średnia Vśr", "Teoretyczna Vt"), 
       col=c("blue", "red"), pch=c(16,17), lty=1)

ed <- c(291.4808625,
        201.7467631,
        153.2670675,
        118.9115722,
        93.50961685,
        73.11228423,
        57.25295628,
        42.37134545,
        28.53528209,
        14.70036488)

et <- c(295.0211159,
        178.7405624,
        115.6972244,
        77.45405697,
        52.4675759,
        35.26003739,
        22.93645863,
        13.84077847,
        6.966258976,
        1.67064632)

plot(x, ed, type="p", col="blue", pch=16,
     ylim=c(min(c(ed, et)), max(c(ed, et))),
     xlab="Odległość x [m]", ylab="Nateżenie pola E",
     main="Zależność natężenia pole E od odległości x")

lines(x, et, type="l", col="red", pch=17)

legend("topright", legend=c("Doświadczalna Ed", "Teoretyczna Et"), 
       col=c("blue", "red"), pch=c(16,17))
