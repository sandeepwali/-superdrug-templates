<!--

Björn Möller SoluM Europe GmbH
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:saxon="http://icl.com/saxon" extension-element-prefixes="saxon" xmlns:dgext="xalan://com.diatoz.graphics.GraphicsUtils" >
	<xsl:output encoding="UTF-8" />
	<xsl:decimal-format name="de" NaN="" decimal-separator="."/>

    <!-- Global variables --> 

    <xsl:variable name="default_font">
        <xsl:text>Arial</xsl:text>
    </xsl:variable>

    <xsl:variable name="price_font">
        <xsl:text>Arial Narrow</xsl:text>
    </xsl:variable>

    <!-- Image Data variables --> 

    <xsl:variable name="pink">
        <xsl:text> data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAG0lEQVQI12P4v+3g//8ik/8z/BeZ/P//toP/AW1cDDUaFXNvAAAAAElFTkSuQmCC</xsl:text>
    </xsl:variable>

    <xsl:variable name="pink2">
        <xsl:text> data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAIAAAD91JpzAAAAFklEQVQI1wXBAQEAAACCIPs/mmAqgjov7Ab7t+0qhAAAAABJRU5ErkJggg==</xsl:text>
    </xsl:variable>

    <xsl:variable name="starbuy_132x30">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIQAAAAeCAYAAADtubaCAAAB0ElEQVRo3u1bMU4DMRAciS+kp6I8GjokvpK35A+ReABfQDqJ8r6Qp1Cgo1o6BEeSs9e73iUZN9PEuc3aHs/sbSDjJLLZC5Eom72ASSD+RDAJKyhChiBO8meQIZyTXHNCaz5vwQilgwxhcNJqkhqRfM0gQxgm15pRvOI+xyBkiMakaug7UkNckbZAt7u4l+awjn+cRIZnu00erZHSMETrpopiCM94EjINQtS6F0OUfn+toLVwGcfmJRSmSGHhWk9Q6WJpBa2F21gTqEk0ClJZuZbFOLc4rZa3Jv7l7zilFZJaWoSVg72HhkFKr6vSRdRu+qt+l2HFBB51A82mKBHWiSugfSqVWou6duI1ybdwAZprr+UQXFylUmtR106eRnN4aR+NRji26YKZI64OUXv3l9K15UmzEK41TJKgOIdU2kBbPrZwFa3vYKy1T1Dx6n/WIbSL411Ua2WABEITIS6iR61/eY30jrs0/jUNMX92dRk3u7eHHV7uge0BLvj4Cgzzb9TM1z53e2ibr427NP67W3yP5fOGGXga4bo+S2S7XKI6DHsqidlecJEheuD7RxoXQYbI3MWdsDeTDBHdq3lV/RBEn15TMsQFuwv+c4uYGb8AMOGFAwbfRngAAAAASUVORK5CYII=</xsl:text>
    </xsl:variable>

    <xsl:variable name="starbuy_200x20">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAAAUCAYAAADIpHLKAAABHklEQVRo3u2aQRICIQwE9xH+3L9492XxuoUBhg1B3Gouc1BxK2bsJHDY6232eBqKot96EAQUretBECap2fx9vUW8IcgWOpKcGcnbW/xOEOQvzHF+f9ZzZJsRhSChpFTKq4ykLffFHBBki15i1CQrCBI1B+aCICkmUZIq0qMon4uaFnNAkJ+apdWztJK7l/TKUqZqnllo9CFIevmlrFYvoSSpYq7SDKWevx+SQJAlJlGmTbXXo+Wbt59i4ivlIwQhCEOHfsro1fvHvtoT9MojhWg1cmASCLLkkE4lhGeWaA+kEsIzJ70IBFl2kp4xEh4ZEPSex+tJMAcEuWXPs8tdMQiC3oqIxAGCoBAEgqDjxIAgEASddE0FhSDcTkYV/QCvXpJEcpRBWAAAAABJRU5ErkJggg==</xsl:text>
    </xsl:variable>

    <xsl:variable name="starbuy_132x30_red">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIQAAAAeCAYAAADtubaCAAABrElEQVRo3u1aWxKDMAgUx7N4/7PZA6Q/zYzN5EFieKjLZ6c6AZZlwVBYlrDAYD9bEQIYANFj4V0ESmgZTCAQARCiQeYGOD6jlZAeRnggSDazAHMS7Z2utcF6ew1xx/5bSi7RK9rGpgqGuwSUiN/eHgaS1bzy7gCOfZdjvBBcMamcqJyh0kdEqKQ+mH0eS//MRKWm81yR1yMGa6K4xw+HydcFRNqHJWf89H2lZM2mZoldhfH+Q5YhojOtRKQVm/v/lWRq9ugzGHPALPnoREfotIw0KFzm8CJyr5x/xCfDlmLzLSPO9DMcb71ndPwtickrYyiXMR/NEC3xldMaucDlEjQCKIk+P1sLGOqITRwM2hOMloDkCugWU6Wgr/miAAydTWWOJUoBvFpJrcRJ6xAuEGsrckOxabOHkEhYfJZTrdZnHW2vj91DzA6uZhBrlZ3TPL0LqRnM6XbKaH05bE0Io8+ffzszx4xzj05PvZNNtM9HFfC4MWVtzlbauFMJAyBgAIStHYe7ew/QEJ60QmkKc6AhAAhLUDgDA1qGevmRazCAITywhbPbUwAE7M++XxzGePVdyrgAAAAASUVORK5CYII=</xsl:text>
    </xsl:variable>

    <xsl:variable name="starbuy_200x20_red">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAAAUCAYAAADIpHLKAAABH0lEQVRo3u2a2w4CIQxEqfH/f7k+GRvCpbsUFuI5iS+K1N3M7LRE0ZQ0AUCRF7cAoM6bWxCEakoi8XvmRNcADDJdnKpr6tv3MQot1hHmmIWtJ/J7AQmyhTl2FCPpQYJsnSInm0N1v2vCIAdiBRglqtY+nv3v/AZbk+ShxVpmkpbISuta4r4rfO9sVPrMey2AQYbMIuITf2mdV6T2u/k6u4c9Ys6PmzkqxiBLzdJKiVyYs4TYa5l6yUSKMIM8OqC3nu4jT/I8wUq1ekbKj4wZ3EmQcJN4hW3N0WvJIlKjVKPWmpEcGCSslbo6ENfWtWaKqIH8W6O3P0bxSYF/8x6SZKNCnjkTkSDwaJoBQzoABoE9DhmAFgswCUM6rBvy/5QPNnmYIujc7JEAAAAASUVORK5CYII=</xsl:text>
    </xsl:variable>

    <xsl:variable name="madeby_132x30">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIQAAAAeCAYAAADtubaCAAACGUlEQVRo3u1b2a7EIAjVxv//Ze/LbdIxyO7WQjIvrVUROGxOTinVFBT0T1ccQdCTysjJa/0Fn5yz6H1vLDYOmlezhuZ7yVzQPBSPkjP4FEJwBId9a/l+Bx6ORYjVhCFSrbVrZZ7Wh1l6u4ecc/fdDHSYjhCtQCzWpLGwkQc5QoEgHkfzcK2wVC2DHodxglKsdC/ltMN4wqrH3FTwZlUozVyt65ipzEennbsGZiNQdRaylVOEOBPqVwWVO9C18pAl9YQ7XWwVyoISq4RBBY6fUIhwM2dQOUFwPUuWCncXZZgdKL4qy1iRLWjKzm9BpKkuo63KrfLzu1jljjWRnKL9HSR1GZ4QGrR3nFI8Arsd82nrQZ7MjyVuIRHii9b/ZcQrVi0Ld7E3wkHFPLTZiAWVkol66R8GwZK0sDeWsx7k+jRrY3t6NqSgcRL+PRpo2jZ64Vg/1HmzogOlKM9DpITMfYbNx0FFak8SY8H2oI1jOBd+qHjv4i50/zyCF4phTd/Dim4SFJMITFoc8zAySxggLky1yoE1m7AbUhh0c561e7g131OZMMFjz7i8elUxMXlIlZgVQ1C9BAzKoY1y/LhkHCdm0ApCc6+xN44TM1ivzVHxCjWXuTAFXeSAFr+fa0rWmGL0LJWzZ0p5e7xpy+7QviRKP6OmsrR0/YYi0KhU0SvbkGYx8c+tlygDFVscgRBB+oxoFIVCBP3QH4T4zGhdHNydAAAAAElFTkSuQmCC</xsl:text>
    </xsl:variable>

    <xsl:variable name="exclusive_132x30">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIQAAAAeCAYAAADtubaCAAACOklEQVRo3u1a2Y4EIQjUjv//y87LmBgjUCVOTx+QbLLrKsghFrQ5pVRTUNCXjjBBUE8FmVSrnkRyzmHJi1HvM8Y/xcu01ppqrY8JiqbznfWxDrArQ7zx9L854xVvlMV1ce0M1zI46rOsVRkMozZ/nKOlYC3oJD7ovH58dvWtyNb2lHNW5zH6s4dsxkfS35JRkNPfGLIBsnpXj7jEcjI6pvFDsqK1J+awaHtYxTHS/FGuxvdABbWfHeDFUng27j01yHr0FDMOYzLRrkPmgQF0H2IMjlFI/7f0u5W6kbFxDy3ydwaT5nhtDNXVUw1otvBUTxCG0EpOK5XPNorc48w8BDOsOoLha81DMANz36M4jgkId2NqFCCBqzaOKjeuZYzV74EJNAsfeHSQ9sUE/Rk9FTVDRBPof6XirmqDrWLiW8ZDgsHCFrfIEEHrFdGvKAIiKK6MILLK0MojDWVL3bhZaSWVRlbbV0uvbS7Cn2kb72oNa2WrdW0gtlkp78f1hUWiksFnjmNapqs1tocvVY4ZcnfYw2svScb21rVV5//C+V50PesK/mtPkvOtk8v0Jnbpd5zppDvxfQKt2IZ6DzHrPJ7plN0yvW3i14DKKxsGbeD0WEdKp+w3AgtTPCGwiud09c5ZeTzjkcnIPiP9Ih+xroBdog9xEVD76MbUrOSSnpMxkbq67o4BYulm2Zj9P7zXNGld725MIS+tkHVoYwoxPNuYYpxn2cODQVbeqDC6xLeMoMAQQREQQSB9AJxSRa9/slPdAAAAAElFTkSuQmCC</xsl:text>
    </xsl:variable>

    <xsl:variable name="exclusive_132x30_text">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIQAAAAeCAYAAADtubaCAAABrElEQVRo3u1ZQRLDIAjUTv7/ZXtpZqwTFER0NewtqRYDK64QQwgpOBw/XDOMpERzLsb4N+Z+LueW76n/lcznjGu9p+w+zeV8Szm25jMLfFCYyXEEh2Tc+aMJrrHLJe0xGaKX2RxH5b/d41NKU5xb2rawO5skMBlCkiUootzPCDttRBY8PkPMSKOryNBrF+m4mE4IjgiMMULvIOp7rALK8dmxR8Yu4N54djw24ESl1lGrBKWV7VeLSu1OygNjfVSMOC7Q9AMcIaQOogI/ysHamsiOgBOVTwKzTMW58NQErbf6SY3lElEinF8rKqXZgRrX6yzJ/3HfbSmYgze3HH7tdDghHHiikqvMn+74Ur0gaU9LxKa0vV5bR0tYrtAlkBnCogXeU8+w+I6yhuEZorELuLu2RQZJJdGi6lhbR83u6tvKKzSExMmWAUFvzx9HCJRdVlsHer3iQgnirHPdsWGG0FYrHQeJSu1VdIdjzTXEZHKtJkxrHciE/rwh8CNqECPItkNmu8JhyFvm3ONJ2mLmBLZnHZ4hjLKE9ronba1rW+dQfg3e/nacKiodenwBVqlBYgT5yl4AAAAASUVORK5CYII=</xsl:text>
    </xsl:variable> 

    <xsl:variable name="exclusive_148x30_text">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJQAAAAeCAYAAADKFzdqAAABrklEQVR42u1a0RKEIAjUpv//Ze+pGc/RBBEFW97qKA3XZeWIIYQUYLBJdluYREptTMcY/3ye6/LZ8n7rvZznKX69+61xa89SvqX0fYvZDru8IJ8SSApIqc/P3iCScamgB0MJdxYl0Plvj39KacnilGNrjGsNZG4YisNSLaA911Z3OpeFwVAKaYULjl1gGh3XU7ozByiKiI4xutnB+Ty1AEGJGVKec6OeOE9Me+5EuTTQuwS51tgQ5RsFbL6w2qluRrrzpp/cAYob4BZwZi2QtCZ2orkT5TWBXqaSXLhLFn20+t7ypQKZc/CAKF/ETi2/0WBz3ke9d+SBJODPYRhEOQyAgkGUWxPoNT0y2sbBaS/hiHVue8zbPHrC3KIuc8lQGi0sI/Usje8oa1hgqNmnhk7jGtevxhi9SrZG1fttHm/jWj8tQkMxF0lzQa231wBQRJ1jaR7e61W3FxCs0jWwDzKUtFoOgyhn+Xlmq1XtNWCoieDcDbjePDxviAvAmVODmgHWE3TgHT5mecsLNb1yW0QowBiZBxjKKEtJj+vc1hhp64uruAe0r8DAUDCr9gMX0EFi2JbjUAAAAABJRU5ErkJggg==</xsl:text>
    </xsl:variable> 

    <xsl:variable name="madeby_148x30">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJQAAAAeCAYAAADKFzdqAAACIElEQVR42u1ay67EIAgtTf//l51Vb+YaRF6OqJDMpmMrCB4OKFzXVa6UFCe5cwlSPOWZOXkp/8ERAET/t8ZS47DvaubQvC/5Fvadno2SNUiEMgSq9F3L+xFsOBahZguFiKWU5i733P0U0tQ6AEDzvwjoFA6haodadrNmh890hEZHzMbZNtwRkUK7QB6LuUJQRU6Py6c8jLh7LXAr7WlJvVeBUKe+SJth67bBqsRWg6RRkPXZJQh+uaCzSPkKckfdcRzH1SQeK/ktKDXLmT3inQGVafIYeXZwfAtJpMERJZiiEe2jqrwZ1Zrm2OQURAyV8uqu8CyeEwUVVuyJwZXXV1KipTzPFJCyNk97Riv1lvK7BNVr88r2jORtZoQ6EX0ScQcEFDfKc/FjIyzWDLb4zETKpYpgqY9KIZKyvjWWMx+WujVzUzp9H+hi4yT2exxAj7oGY0p59eJ7Rnov0L6d0AsS7jPqexxU7ukk2WyUDloex7kwaOW7Ln0oAPj7eZC/3oJpzv2s6CpBUYnDpc1Vj006kqy7Nzbr4KIOa6kbmlTq4TyrdXh3nmcwUoFDPePa6lWNUf7wrl5dOFTvLI1KRZihHB4jGcfhTFpHau51t8ZxOJOV7/T4mjWghjc2sYtgmPLvc82RCxVYLaTg6NwL/pZt2mMjTC/JponQUwt99LJDE3FUqe9V7Xm3evI+1CHB1ONWRyBUir4inSUZUCmu8gFElMxoAS/j2AAAAABJRU5ErkJggg==</xsl:text>
    </xsl:variable>

    <xsl:variable name="starbuy_148x30_red">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJQAAAAeCAYAAADKFzdqAAABtklEQVR42u1aS64DIQybVD1L73+29gC8FRIa8QkQwHljL6tOOyTGcQISritcBGGEF0NAkFBICBT4FMKSZ0QkEcYEjlBpkrQJis/sSmiPIj2QZG/YkqEhCnq52U32x3soj/6jRA4Rlr2jCpUjk5eEiOjL88NI9oLf+R7I9fmsU9wQXCn5OVNu0SWNmPiV/sj6fU6uz60p3xk8rUnuMdO1pqJnHQ7Jg0Wouw+xVq/a75WSbV1aVsyqwOdfZxUqBqOVyLti5L4/Q4adHiUlc47YpTU68VEYJe8eVK1yoTQJM+8/sibgkoh5lhdnOhaBa/3O6PiiZMZnxghaxaZCKUuA1mvlAp9L8AghV/gcay8E7KPex8l06n9WG3BtA9JSyvumqa0FgFgYk/KcSpUSMLuTW4lf7cO0RK4d8QCbdcw51IqEx2c1anH6XUftwaMJ1ZPY2SDuTEJNWXKer3egaaHc/7bLa53ctzq00efTz1Llsnjv0e61t7OM+P2gVIs3NtHh7EiGd8oJEoogoYgavl93957ooTx5pVIX7MBDkVDIpHJGJpY8uO0trslEhfKgVs5ub5JQhCn+AH35xnhmauWFAAAAAElFTkSuQmCC</xsl:text>
    </xsl:variable>

    <xsl:variable name="starbuy_full_148x148">
        <xsl:text>data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJQAAACUCAYAAAB1PADUAAAGPElEQVR42u2dW5LbNhBFKZb2Fsk/ySqSHcWRF2Ini3OYr6liKUMSj27gNnBulT88M6LwOOxuNF63bVm2BSEjrTQBAigEUAigEAIoBFAIoBACKARQCKAQQCEEUAigEEChbfv/v+eDdjnQjeUrBxBlteKNNsNCGcFU+hmAGlzPRx0YQIXLuwTiypWVfAagJoQpBwqgwuWZuioCcoAyB+T9MxPHU3MDVePqCNIB6lRfnrg+gnJB6+Rp9bBQCJdHII4ASihgnnzEh4XysE4kNrFOw30nQAUe2WGlcHlYKYCKY50Y5SHcHkDFczcTuL05LVRLyzFZXmp8oBRip4mgIoZCABVyZDdJgI6FIkAHKCwEQGEBJgnO57BQWCeAGjY+GdxKrcPDFME6DQQVozxcsKnuQ7u0SB13VqdA9dDbRmVp/tU7wqquQvW8h4eGkZ2UdfOzUECj34YO7bdKN8Ttdv5vhuDds/7btizPX3SB+vf1tex8ylmB8QQuVd//NrWEdi7v9dey/P4H7iqy2zToExugjgoNNLp6Ppbl+w/zPqsHiiMBx7NiFf1nH5QDU8xYzGhQtaqQjcZQjKmXsxjt43cfMKf+/+rt3P/86hmfPe8sFLgqY4+Xdd+WEmkD73MC9s8vTSvsO+4KsNzR0VGZSobyKeVUGh2aWKgRllykdLJ3PT+zToHj0nGWr3zcFJUCUMrf5gCwv6nqqFxHv/MqZycrdR8GqFTXsI8VrqzD/vdnnethXXLKiYUSgE/BxVzFSAGnoNZqizCaW1Sob29XV1Hn1bQRIrnFVDdyNHLLiZOuADlLJ/Ryd4XfVzf1QmJzHBn15epaKDSd6oD6jGKgim+dapBwW77Swv2VDONLGi/lxUmtb+P1Sa37zsbltbZUV0Fuj1GSx/d518PBEPjO5Xk1cu+YbgS37uRV7He9eLu/FFez/5vc+bra+b2ci69zXLP35ZBGz2+zwM7rjT5qhLNlIK3KoPpc5xf+7tYY7wXftr6n73p0SLS8W4O84dq0Q62tRUoWujW8VmWxBrdRG93dG9raUh2tLIxoOVq9CA3TOmvTt9eqIVMCX+8RZssVCUFgagOUJ1S9wGrh9mqXrhzV3flFaLfA7sj91Vay1YjO49leZe+48bb9+VCtKpszoklxZSVnNuR+l8UorPPG2/YrNi3MeErn9g7MLeYMrVxnQ/VZAtwqpRBtNFYDwPMhMSXUb5NCbUrhLP7yTODlTK1YwVz6nR2sdN9NCkcw5DTQ3g2OkuQs2RQq4vL773rJDYJzG8oyj9MrLjtqC8FjlDS2UZVAlbK5QCFj7mWlRLdd6ezLO2iIn68/r6GpPU7R+myCs7LkPO/ob4XP5IpxTjm7adoNOoaxUMAzhDS3ogNV2Lbi8iA0AVDs7UvX66uWwZQLyo+CTqv9bDl5paO/9dgEkZvMJShvDGTP1ZA5MCnuMRwaKMUA3WqXcOkeQ+FBS8wT7FJdWqudNinfk5rIDB5PjufyVNZ651oUhT2GACUEr2dnB7qhS8/l1XaM2uqAkngrcGJ37EusW1mp99N6Sz5bA1frXdlhXJ7l7ZIK295rYifSBvX6+duvdlD07oiS5S459RF1i1qZ8rMMsNUxOBaZ8hZxUErmXBCwMdMGwYbaWSM78fqQNuhpjaPsMQSoTkP/nqNaEcu1SnZgKxhyb4nytlYlMaGY5stDnR3a0TpGUijHNC7P4k2syQ+1sAi1ewwFrdU49+XldtbVor3Wk8wKZZkKKI9GtX6m1TlXuDyEhIHavjw0BwLqQbNA+VbFhrj9+EcLovdVoMpgWU6wl3huibk8tVyL2o1RgdqPrei1biPY8hJGeQogpUw297obGKCCgvT+szOwJoZqBaZC11syR4iFmgyiXJd15QondIOau148OsASpLPPTw7W+BbKG6QSsCy/V8y16qwpt86ltAbJI07r0W5YqA6dqOIK3w+0FXCpuhaqpIFUrFKr8gmu5hzjFOCIa4msblYXq2cMoGrdTdQBQ8B6ah6JWNvY0W8rD1xXXaBKGjp6nmeA+mpPvVydi1RzHYd4fbdvr5D11bZQKJxYU44ACgEUAiiEAAoBFAIohAAKARQCKARQCAEUAigEUAgBFAIoBFAIfaL/AJfHHmhf/Uw7AAAAAElFTkSuQmCC</xsl:text>
    </xsl:variable>

    <!-- Product Data variables --> 

    <!--
    <xsl:variable name="">
        <xsl:choose>
            <xsl:when test="$is_offer">
                <xsl:value-of select=""/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select=""/>
            </xsl:otherwise>
        </xsl:choose>     
    </xsl:variable>
    -->

    <xsl:variable name="offer_type" select="/articles/article[@index=1]/data/offer_type"/>
    <xsl:variable name="offer_desc" select="/articles/article[@index=1]/data/offer_desc"/>
    <xsl:variable name="offer_qualify_qty" select="/articles/article[@index=1]/data/offer_qualify_qty"/>
    <xsl:variable name="reward" select="/articles/article[@index=1]/data/reward"/>
    <xsl:variable name="offer_qualify_qty_2" select="/articles/article[@index=1]/data/offer_qualify_qty__2"/>
    <xsl:variable name="reward_2" select="/articles/article[@index=1]/data/reward__2"/>
    <xsl:variable name="reward_type_desc" select="/articles/article[@index=1]/data/reward_type_desc"/>
    <xsl:variable name="bul_two" select="/articles/article[@index=1]/data/bul_two"/>
    <xsl:variable name="bul_two_2" select="/articles/article[@index=1]/data/bul_two__2"/>

    <xsl:variable name="offer_type__loyalty" select="/articles/article[@index=1]/data/offer_type__loyalty"/>

    <xsl:variable name="UOM_Compare">
        <xsl:choose>
            <xsl:when test="/articles/article[@index=1]/data/CMPR_UOM_AMT = 0">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="/articles/article[@index=1]/data/CMPR_UOM_AMT"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="UOM_Amount">
        <xsl:choose>
            <xsl:when test="string-length(articles/article[@index=1]/data/product_size) &gt; 0">
                <xsl:value-of select="/articles/article[@index=1]/data/product_size"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="/articles/article[@index=1]/data/BS_UOM_AMT"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="UOM_Unit">
        <xsl:choose>
            <xsl:when test="contains(articles/article[@index=1]/data/uom, 'each')">
                <xsl:text>EA</xsl:text>
            </xsl:when>
            <xsl:when test="contains(articles/article[@index=1]/data/uom, 'g')">
                <xsl:text>G</xsl:text>
            </xsl:when>
            <xsl:when test="contains(articles/article[@index=1]/data/uom, 'l')">
                <xsl:text>ML</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="/articles/article[@index=1]/data/UOM"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="UOM_Label">
        <xsl:choose>
            <xsl:when test="$UOM_Unit = 'EA'">
                <xsl:text>each</xsl:text>
            </xsl:when>
            <xsl:when test="$UOM_Unit = 'G' and $UOM_Amount &lt; 16">
                <xsl:text>per 10g</xsl:text>
            </xsl:when>
            <xsl:when test="$UOM_Unit = 'G' and $UOM_Amount &lt; 1000">
                <xsl:text>per 100g</xsl:text>
            </xsl:when>
            <xsl:when test="$UOM_Unit = 'G' and not($UOM_Amount &lt; 1000)">
                <xsl:text>per 1kg</xsl:text>
            </xsl:when>
            <xsl:when test="$UOM_Unit = 'ML' and $UOM_Amount &lt; 16">
                <xsl:text>per 10ml</xsl:text>
            </xsl:when>
            <xsl:when test="$UOM_Unit = 'ML' and $UOM_Amount &lt; 1000">
                <xsl:text>per 100ml</xsl:text>
            </xsl:when>
            <xsl:when test="$UOM_Unit = 'ML' and not($UOM_Amount &lt; 1000)">
                <xsl:text>per 1l</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="/articles/article[@index=1]/data/LBL_UOM"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="UOM_Compare_Calculated">
        <xsl:choose>
            <xsl:when test="$UOM_Label = 'each'">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:when test="$UOM_Label = 'per 10g' or $UOM_Label = 'per 10ml'">
                <xsl:text>10</xsl:text>
            </xsl:when>
            <xsl:when test="$UOM_Label = 'per 100g' or $UOM_Label = 'per 100ml'">
                <xsl:text>100</xsl:text>
            </xsl:when>
            <xsl:when test="$UOM_Label = 'per 1kg' or $UOM_Label = 'per 1l'">
                <xsl:text>1000</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="/articles/article[@index=1]/data/CMPR_UOM_AMT"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="detected_group_promo">
        <xsl:choose>
            <xsl:when test="contains($bul_two, 'EVERYDAY LOW PRICE')">
                <xsl:text>Everyday low price</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>NONE</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="promotype">
        <xsl:choose>
            <xsl:when test="($offer_type = '101'
                            and $offer_qualify_qty = '2')
                            or (($offer_type = '131' 
                                or $offer_type = '132')
                                and $reward_type_desc = 'Free item'
                                and $offer_qualify_qty = '2')">
                <xsl:text>BOGOF</xsl:text>
            </xsl:when>

            <xsl:when test="($offer_type = '101' 
                            and $offer_qualify_qty = '3')
                            or (($offer_type = '131' 
                                or $offer_type = '132')
                                and $reward_type_desc = 'Free item'
                                and $offer_qualify_qty = '3')">
                <xsl:text>3_FOR_2</xsl:text>
            </xsl:when>

            <xsl:when test="($offer_type = '102')
                            or (($offer_type = '131' 
                                or $offer_type = '132')
                                and $reward_type_desc = 'New Price'
                                and $offer_qualify_qty = '2')">
                <xsl:text>2_FOR_X</xsl:text>
            </xsl:when>

            <xsl:when test="($offer_type = '103' 
                            and /articles/article[@index=1]/data/pe0033_line_count = '2')">
                <xsl:text>2_AND_3_FOR</xsl:text>
            </xsl:when>

            <xsl:when test="($offer_type = '103')">
                <xsl:text>3_FOR_X</xsl:text>
            </xsl:when>

            <xsl:when test="($offer_type = '104' and $reward = 50)
                            or (($offer_type = '131' 
                                or $offer_type = '132')
                                and $reward_type_desc = 'Percentage off'
                                and $reward = 50)">
                <xsl:text>BOGSHP</xsl:text>
            </xsl:when>

            <xsl:when test="($offer_type = '104')
                            or (($offer_type = '131' 
                                or $offer_type = '132')
                                and $reward_type_desc = 'Percentage off')">
                <xsl:text>PERCENT_OFF</xsl:text>
            </xsl:when>

            <xsl:when test="($offer_type = '105'
                            or $offer_type = '106'
                            or $offer_type = '107'
                            or $offer_type = '108')
                            or $offer_desc = 'Group Promotion'
                            or $detected_group_promo != 'NONE'">
                <xsl:text>GROUP_PROMO</xsl:text>
            </xsl:when>

            <xsl:when test="($offer_type = '000' 
                            or $offer_type = '131' 
                            or $offer_type = '132') 
                            and (string-length(/articles/article[@index=1]/data/new_was_price) = 0
                                or /articles/article[@index=1]/data/new_was_price = 0)">
                <xsl:text>ONLY</xsl:text>
            </xsl:when>

            <xsl:when test="($offer_type = '000' 
                            or $offer_type = '131' 
                            or $offer_type = '132')">
                <xsl:text>PRICE_CUT</xsl:text>
            </xsl:when>

            <xsl:when test="string-length($offer_type) = 0">
                <xsl:text>NO_PROMO</xsl:text>
            </xsl:when>

            <xsl:otherwise>
                <xsl:text>UNKNOWN_PROMO</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="is_offer">
        <xsl:choose>
            <xsl:when test="string-length($offer_type) &gt; 0">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="is_offer_box">
        <xsl:choose>
            <xsl:when test="$is_offer = 1 and $promotype != 'ONLY'">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name='members_only'>
        <xsl:choose>
            <xsl:when test="/articles/article[@index=1]/data/pe_duration_days = 7">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:when test="/articles/article[@index=1]/data/pe_promo_type = 'LOYALTY'">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name='members_price'>
        <xsl:choose>
            <xsl:when test="$members_only = 1 and $promotype = 'PRICE_CUT'">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name='starbuy'>
        <xsl:choose>
            <xsl:when test="/articles/article[@index=1]/data/pe_duration_days = 7">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:when test="/articles/article[@index=1]/data/pe_promo_type = 'FRAGRANCE'">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name='is_big_starbuy'>
        <xsl:choose>
            <xsl:when test="$starbuy = 1 and /articles/article[@index=1]/data/pe_promo_type = 'FRAGRANCE'">
                <xsl:text>0</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name='superdrug_brand'>
        <xsl:choose>
            <xsl:when test="contains(/articles/article[@index=1]/data/Brand_Cat, 'P (Private Label')">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name='exclusive_brand'>
        <xsl:choose>
            <xsl:when test="contains(/articles/article[@index=1]/data/Brand_Cat, 'X (Exclusive Brand)')">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name='is_banner'>
        <xsl:choose>
            <xsl:when test="($starbuy = 1 or $exclusive_brand = 1 or $superdrug_brand = 1) and $is_offer_box = 1">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name='bannercount'>
        <xsl:choose>
            <xsl:when test="($starbuy = 1 and ($exclusive_brand = 1 or $superdrug_brand = 1)) and $is_offer_box = 1">
                <xsl:text>2</xsl:text>
            </xsl:when>
            <xsl:when test="($starbuy = 1 or $exclusive_brand = 1 or $superdrug_brand = 1) and $is_offer_box = 1">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="is_doublebanner">
        <xsl:choose>
            <xsl:when test="$bannercount = 2">
                <xsl:text>1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>   
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="barcode" select="number(/articles/article[@index=1]/data/INTRNL_ID)"/>

    <xsl:variable name="brand">
        <xsl:choose>
            <xsl:when test="$is_offer = 1">
                <xsl:call-template name="titleCaseMe">
                    <xsl:with-param name="text" select="/articles/article[@index=1]/data/item_brand"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                 <xsl:text/>
            </xsl:otherwise>
        </xsl:choose>     
    </xsl:variable>

    <xsl:variable name="desc">
        <xsl:choose>
            <xsl:when test="$is_offer = 1">
                <xsl:call-template name="titleCaseMe">
                    <xsl:with-param name="text" select="/articles/article[@index=1]/data/item_long_desc"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="titleCaseMe">
                    <xsl:with-param name="text" select="/articles/article[@index=1]/data/DSPL_DESCR"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>     
    </xsl:variable>

    <xsl:variable name="desc_short">
        <xsl:choose>
            <xsl:when test="$is_offer = 1">
                <xsl:call-template name="titleCaseMe">
                    <xsl:with-param name="text" select="/articles/article[@index=1]/data/item_desc"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="titleCaseMe">
                    <xsl:with-param name="text" select="/articles/article[@index=1]/data/DSPL_DESCR"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>     
    </xsl:variable>

    <xsl:variable name="now_price">
        <xsl:choose>
            <xsl:when test="$is_offer = 1 and $promotype = 'PRICE_CUT' and (/articles/article[@index=1]/data/now_price - $reward * 2) &lt; 0.02">
                <xsl:value-of select="$reward"/>
            </xsl:when>
            <xsl:when test="$is_offer = 1 and $promotype = 'PRICE_CUT' and (/articles/article[@index=1]/data/now_price - $reward * 1.5) &lt; 0.03">
                <xsl:value-of select="$reward"/>
            </xsl:when>
            <xsl:when test="$is_offer = 1 and $members_only = 1 and $promotype = 'PRICE_CUT'">
                <xsl:value-of select="/articles/article[@index=1]/data/now_price - $reward"/>
            </xsl:when>
            <!-- Special treatment for 50.01 case -->
            <xsl:when test="$is_offer = 1 and $members_only = 1 and $promotype = 'PERCENT_OFF' and $reward = 50.01"> 
                <xsl:value-of select="/articles/article[@index=1]/data/now_price div 100 * (100 - $reward) - 0.01"/>
            </xsl:when>
            <xsl:when test="$is_offer = 1 and $members_only = 1 and $promotype = 'PERCENT_OFF'">
                <xsl:value-of select="/articles/article[@index=1]/data/now_price div 100 * (100 - $reward)"/>
            </xsl:when>
            <xsl:when test="$is_offer = 1
                            and (/articles/article[@index=1]/data/now_price &lt; /articles/article[@index=1]/data/RTL_PRC
                            or string-length(/articles/article[@index=1]/data/RTL_PRC) = 0)">
                <xsl:value-of select="/articles/article[@index=1]/data/now_price"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="/articles/article[@index=1]/data/RTL_PRC"/>
            </xsl:otherwise>
        </xsl:choose>     
    </xsl:variable>

    <xsl:variable name="base_price">

        <xsl:value-of select="concat('£',
        format-number($now_price
                        div $UOM_Amount
                        * $UOM_Compare_Calculated, '0.00','de' ))"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$UOM_Label"/>
 
    </xsl:variable>


    <xsl:variable name="new_was_price">
        <xsl:choose>
            <xsl:when test="/articles/article[@index=1]/data/new_was_price = 0 and /articles/article[@index=1]/data/new_was_was_price = 0">
                <xsl:value-of select="/articles/article[@index=1]/data/now_price"/>
            </xsl:when>
            <xsl:when test="/articles/article[@index=1]/data/new_was_price &lt; /articles/article[@index=1]/data/new_was_was_price">
                <xsl:value-of select="/articles/article[@index=1]/data/new_was_was_price"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="/articles/article[@index=1]/data/new_was_price"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="new_was_price_per_uom" select="/articles/article[@index=1]/data/new_was_price_per_uom"/>
    <xsl:variable name="new_was_price_per_uom_2" select="/articles/article[@index=1]/data/new_was_price_per_uom__2"/>

    <xsl:variable name="was_base_price">

        <xsl:value-of select="concat('£',
        format-number($new_was_price
                        div $UOM_Amount
                        * $UOM_Compare_Calculated, '0.00','de' ))"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$UOM_Label"/>

    </xsl:variable>

    <!-- Template
    <xsl:variable name="image">
    <xsl:text>data:image/png;base64, </xsl:text>
    </xsl:variable>
    -->

    <!-- Main Template -->
	<xsl:template match="articles[@page=1]">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="{$default_font}" font-weight="normal" margin="0px" padding="0px" wrap-option="no-wrap">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="only" page-width="384" page-height="168">
					<fo:region-body region-name="xsl-region-body" hyphenate="true" xml:lang="de" language="de"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
            <fo:page-sequence master-reference="only">
				<fo:flow flow-name="xsl-region-body">
					<xsl:call-template name="LAYOUT29"/>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
    
    <!-- Utility Templates --> 

	<xsl:template name="replaceString">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="with"/>
    <xsl:choose>
        <xsl:when test="contains($text,$replace)">
            <xsl:value-of select="substring-before($text,$replace)"/>
            <xsl:value-of select="$with"/>
            <xsl:call-template name="replaceString">
                <xsl:with-param name="text" select="substring-after($text,$replace)"/>
                <xsl:with-param name="replace" select="$replace"/>
                <xsl:with-param name="with" select="$with"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$text"/>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="titleCaseMe">
        <xsl:param name="text"/>
        <xsl:param name="delim" select="' '"/>
        <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
        <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
        <xsl:choose>
            <xsl:when test="string-length(substring-after($text, $delim)) &gt; 0">
                <xsl:choose>
                <xsl:when test="contains(substring-before($text, $delim), '/')">
                    <xsl:call-template name="titleCaseMe">
                        <xsl:with-param name="text" select="substring-before($text, $delim)"/>
                        <xsl:with-param name="delim" select="'/'"/>   
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="contains(substring-before($text, $delim), '&amp;')">
                    <xsl:call-template name="titleCaseMe">
                        <xsl:with-param name="text" select="substring-before($text, $delim)"/>
                        <xsl:with-param name="delim" select="'&amp;'"/>   
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring(substring-before($text, $delim),1,1)"/>
                    <xsl:value-of select="translate(substring(substring-before($text, $delim),2,99),$uppercase, $lowercase)"/>
                </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="$delim"/>
                <xsl:call-template name="titleCaseMe">
                    <xsl:with-param name="text" select="substring-after($text, $delim)"/>    
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="substring($text,1,1)"/>
                <xsl:value-of select="translate(substring($text,2,99),$uppercase, $lowercase)"/>            
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="getTextFit">
        <xsl:param name="text" select="'123456789'"/>
        <xsl:param name="fontFamily" select="'Arial'"/>
        <xsl:param name="fontWeight" select="'1.0f'"/>
        <xsl:param name="fontStyle" select="'0.0f'"/>
        <xsl:param name="maxSize" select="18"/>
        <xsl:param name="minSize" select="9"/>
        <xsl:param name="maxWidth" select="100"/>
    
        <xsl:choose>
            <xsl:when test="$maxSize = $minSize">
                <xsl:value-of select="$maxSize"/>
            </xsl:when>
            <xsl:when test="(dgext:getTextWidth($text, $fontFamily , $fontWeight , $fontStyle, number($maxSize)) &gt; $maxWidth)">
                <xsl:call-template name="getTextFit">
                    <xsl:with-param name="text" select="$text"/>
                    <xsl:with-param name="fontFamily" select="$fontFamily"/>
                    <xsl:with-param name="fontWeight" select="$fontWeight"/>
                    <xsl:with-param name="fontStyle" select="$fontStyle"/>
                    <xsl:with-param name="maxSize" select="$maxSize - 1"/>
                    <xsl:with-param name="minSize" select="$minSize"/>
                    <xsl:with-param name="maxWidth" select="$maxWidth"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$maxSize"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Layout Components -->

    <!-- Example
    <xsl:template name="">
    <xsl:param name="fontName"/>
    <xsl:param name="fontSize"/>
    <xsl:param name="top"/>
    <xsl:param name="left"/>
    <xsl:param name="width"/>
    <xsl:param name="height"/>

    <fo:block-container position="absolute" 
    left="{$left}px" 
    top="{$top}px" 
    width="{$width}px" 
    height="{$height}px"
    font-family="{$fontName}" 
    text-align="left"
    font-size="{$fontSize}pt" 
    font-weight="normal">

        <fo:block>

        </fo:block>

    </fo:block-container>

    </xsl:template>
    -->

    <xsl:template name="pinkBackground">

    <fo:block-container
    width="100%" 
    height="100%"
    background-image="{$pink}"  
    background-repeat="repeat">

            <fo:block/>

    </fo:block-container>

    </xsl:template>

    <xsl:template name="offerBox">
    <xsl:param name="fontSize"/>
    <xsl:param name="top"/>
    <xsl:param name="left"/>
    <xsl:param name="width"/>
    <xsl:param name="height"/>
    <xsl:param name="linebreak" select="'preserve'"/>

    <fo:block-container position="absolute" 
    left="{$left}px" 
    top="{$top}px" 
    width="{$width}px" 
    height="{$height}px"
    text-align="center"
    font-size="{$fontSize}pt" 
    font-weight="bold"
    linefeed-treatment="{$linebreak}"
    color="white">

    <xsl:choose>
        <xsl:when test="$members_only = 1 or $members_price = 1">
            <xsl:attribute name="background-color">
                <xsl:text>black</xsl:text>
            </xsl:attribute>  
        </xsl:when>
        <xsl:otherwise>
            <!-- Pink dithering pattern
            <xsl:attribute name="background-image">
                <xsl:value-of select="$pink"/>
            </xsl:attribute>
            -->
            <xsl:attribute name="background-color">
                <xsl:text>red</xsl:text>
            </xsl:attribute>
        </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="$superdrug_brand = 1">
        <fo:block-container height="30px" background-image="{$madeby_148x30}" background-repeat="no-repeat">
            <fo:block font-size="{$fontSize * 0.25}pt">
            </fo:block>
        </fo:block-container>
    </xsl:if>

    <xsl:if test="$exclusive_brand = 1">
        <fo:block-container height="30px" background-image="{$exclusive_148x30_text}" background-repeat="no-repeat">
            <fo:block font-size="{$fontSize * 0.25}pt">
            </fo:block>
        </fo:block-container>
    </xsl:if>

    <xsl:if test="$starbuy = 1">
        <fo:block-container height="20px" background-image="{$starbuy_148x30_red}" background-repeat="no-repeat">
            <fo:block font-size="{$fontSize * 0.25}pt">
            </fo:block>
        </fo:block-container>
    </xsl:if>

    <fo:block-container top="{0 + $bannercount * 30}px" height="{$height - $bannercount * 30}px" width="{$width}" display-align="center" absolute-position="fixed">
    <xsl:if test="$members_only = 1">
        <xsl:choose>
            <xsl:when test="$members_price = 1">
                <fo:block font-size="{$fontSize * 0.25}pt" color="white">
                    <xsl:text>member price</xsl:text>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:block font-size="{$fontSize * 0.25}pt" color="white">
                    <xsl:text>member only</xsl:text>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:if>
    <xsl:choose>
        <xsl:when test="$members_price = 1">

            <xsl:variable name="pound" select="substring-before(format-number($now_price, '0.00','de'), '.')"/>
            <xsl:variable name="pence" select="substring(substring-after(format-number($now_price, '0.00','de'), '.'), 1, 2)"/>
    
            <fo:block font-weight="bold">
                <fo:inline font-size="{$fontSize * 0.4}pt" vertical-align="80%">
                    <xsl:if test="$is_offer = 1 and $bul_two = 'ONLY'">
                        <xsl:text>only </xsl:text>
                    </xsl:if>
                    <xsl:text>£</xsl:text>
                </fo:inline>
                <fo:inline vertical-align="top">
                    <xsl:value-of select="$pound"/>
                </fo:inline>
                <xsl:if test="$pence != '00'">
                    <fo:inline font-size="{$fontSize * 0.4}pt" vertical-align="80%">
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="$pence"/>
                    </fo:inline>
                </xsl:if>
            </fo:block>
            <fo:block font-weight="bold" font-size="{$fontSize * 0.2}pt">
                <xsl:value-of select="$base_price"/>
            </fo:block>
        </xsl:when>

        <xsl:when test="$promotype = 'PRICE_CUT'">
            <xsl:variable name="save_amount" select="$new_was_price - $now_price"/>
            <xsl:variable name="save_percent" select="100 - ($now_price * 100 div $new_was_price)"/>

            <xsl:variable name="save_amount_rounded">
                <xsl:choose>
                    <xsl:when test="substring(substring-after(format-number($save_amount, '0.00'),'.'),1,1) = 5
                                    or substring(substring-after(format-number($save_amount, '0.00'),'.'),1,1) = 6
                                    or substring(substring-after(format-number($save_amount, '0.00'),'.'),1,1) = 7
                                    or substring(substring-after(format-number($save_amount, '0.00'),'.'),1,1) = 8
                                    or substring(substring-after(format-number($save_amount, '0.00'),'.'),1,1) = 9">
                        <xsl:value-of select="format-number(floor($save_amount) + 0.5, '0.00')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="floor($save_amount)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="save_percent_rounded" select="format-number($save_percent, 0)"/>

            <xsl:variable name="save_type">
                <xsl:choose>
                    <xsl:when test="$save_percent_rounded = 50">
                        <xsl:text>half_price</xsl:text>
                    </xsl:when>
                    <xsl:when test="($save_percent_rounded = 10
                                        or $save_percent_rounded = 20
                                        or $save_percent_rounded = 25)
                                        and contains($bul_two, '%')">
                        <xsl:text>percent</xsl:text>
                    </xsl:when>
                    <xsl:when test="($save_percent_rounded = 33
                                        or $save_percent_rounded = 66 
                                        or $save_percent_rounded = 67)
                                        and (contains($bul_two, '%')
                                        or contains($bul_two,'/'))">
                        <xsl:text>percent_fraction</xsl:text>
                    </xsl:when>
                    <xsl:when test="$save_percent_rounded &gt; 50">
                        <xsl:text>better_than_half</xsl:text>
                    </xsl:when>
                    <xsl:when test="$save_amount_rounded != 0">
                        <xsl:text>value</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>only</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="save_display">
                <xsl:choose>
                    <xsl:when test="$save_type = 'half_price'">
                        <xsl:text>half_price</xsl:text>
                    </xsl:when>
                    <xsl:when test="$save_type = 'better_than_half'">
                        <xsl:text>better_than_half_price</xsl:text>
                    </xsl:when>                
                    <xsl:when test="$save_type = 'percent'">
                        <xsl:value-of select="$save_percent_rounded"/>
                    </xsl:when>
                    <xsl:when test="$save_type = 'percent_fraction' and $save_percent_rounded = 33">
                        <xsl:text>1/3</xsl:text>
                    </xsl:when>
                    <xsl:when test="$save_type = 'percent_fraction' and $save_percent_rounded = 66">
                        <xsl:text>2/3</xsl:text>
                    </xsl:when>
                    <xsl:when test="$save_type = 'only'">
                        <xsl:value-of select="$now_price"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$save_amount_rounded"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:choose>
            <xsl:when test="contains($save_display, 'half_price')">
                <xsl:if test="contains($save_display, 'better_than')">
                    <fo:block font-size="{$fontSize * 0.25}pt">
                        <xsl:text>better than</xsl:text>
                    </fo:block>
                </xsl:if>
                <xsl:if test="contains($bul_two, 'BUY 1 GET 2ND')">
                    <fo:block font-size="{$fontSize * 0.25}pt">
                        <xsl:text>buy 1 get 2nd</xsl:text>
                    </fo:block>
                </xsl:if>
                <xsl:choose>
                <xsl:when test="$is_banner = 1">
                    <fo:block font-size="{$fontSize * 0.4}pt" line-height="0.9">
                        <xsl:text>half price</xsl:text>
                    </fo:block>
                </xsl:when>
                <xsl:otherwise>
                    <fo:block font-size="{$fontSize * 0.6}pt" line-height="0.9">
                        <xsl:text>half&#xA;price</xsl:text>
                    </fo:block>
                </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <xsl:otherwise>
                <fo:block font-size="{$fontSize * (0.5 - 0.1 * $is_doublebanner) }pt" padding-bottom="-10px" padding-top="-5px">
                    <xsl:choose>
                        <xsl:when test="$save_type = 'only'">
                            <xsl:text>only</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>save</xsl:text>                        
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
                <fo:block>
                    <fo:inline font-size="{$fontSize * 0.6}pt" vertical-align="top">
                        <xsl:if test="not(contains($save_type, 'percent'))">
                            <xsl:text>£</xsl:text>
                        </xsl:if>
                    </fo:inline>
                    <fo:inline vertical-align="top" font-size="{$fontSize * ( 1 - 0.2 * $is_doublebanner)}pt">
                        <xsl:choose>
                            <xsl:when test="$save_type = 'percent_fraction'">
                                <xsl:value-of select="$save_display"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="substring-before(format-number($save_display, '0.00','de'),'.')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:inline>
                    <xsl:if test="substring-after(format-number($save_display, '0.00','de'),'.') != '00'
                                or $save_type = 'percent'">
                        <fo:inline font-size="{$fontSize * 0.6}pt" vertical-align="top">
                            <xsl:choose>
                                <xsl:when test="$save_type = 'percent'">
                                    <xsl:text>%</xsl:text>
                                </xsl:when>
                                <xsl:when test="$save_type = 'percent_fraction'">
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>.</xsl:text>
                                    <xsl:value-of select="substring-after(format-number($save_display, '0.00','de'),'.')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:inline>
                    </xsl:if>
                </fo:block>
            </xsl:otherwise>
            </xsl:choose>

            <xsl:variable name="no_extra_padding">
                <xsl:choose>
                    <xsl:when test="not(contains($save_type, 'half'))">
                        <xsl:text>1</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>0</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:if test="$new_was_price != $now_price">
                <fo:block font-size="{$fontSize * 0.3}pt" font-weight="normal" padding-top="{-15 * $no_extra_padding - 10 * $is_doublebanner}px">
                    <xsl:text>was £</xsl:text>
                    <xsl:value-of select="$new_was_price"/>
                </fo:block>
            </xsl:if>
        </xsl:when>


        <xsl:when test="$promotype = 'BOGOF'">

            <xsl:variable name="xsave_amount">
                <xsl:value-of select="substring-before($bul_two, ' ')"/>
            </xsl:variable>
            
            <xsl:variable name="xsave_for">
                <xsl:value-of select="substring-before(substring-after($bul_two, ' '),' ')"/>
            </xsl:variable>

            <xsl:variable name="xsave_save">
                <xsl:value-of select="translate(substring-before(substring-after(substring-after($bul_two, ' '),' '), ' '), '£', '')"/>            
            </xsl:variable>

            <fo:block font-size="{$fontSize * 0.3}pt">
                <xsl:text>buy 1 get 1</xsl:text>
            </fo:block>

            <fo:block vertical-align="top">
                <xsl:text>free</xsl:text>
            </fo:block>

        </xsl:when>

        <xsl:when test="$promotype = '3_FOR_2'">

            <fo:block>
                <fo:inline vertical-align="top">
                    <xsl:text>3</xsl:text>
                </fo:inline>
                <fo:inline font-size="{$fontSize * 0.6}pt" vertical-align="middle">
                    <xsl:text>for</xsl:text>
                </fo:inline>
                <fo:inline vertical-align="top">
                    <xsl:text>2</xsl:text>
                </fo:inline>
            </fo:block>

            <xsl:if test="contains($bul_two, 'MIX &amp; MATCH')">
                <fo:block font-size="{$fontSize * 0.3}pt" vertical-align="top">
                    <xsl:text>mix &amp; match</xsl:text>
                </fo:block>
            </xsl:if>
        </xsl:when>

        <xsl:when test="$promotype = '2_FOR_X'">
            <fo:block font-size="{$fontSize * 0.6}pt">
                <xsl:value-of select="$offer_qualify_qty"/>
                <xsl:text> for</xsl:text>
            </fo:block>
            <fo:block>
                <fo:inline font-size="{$fontSize * 0.6}pt" vertical-align="top">
                    <xsl:text>£</xsl:text>
                </fo:inline>
                <fo:inline vertical-align="top">
                    <xsl:value-of select="substring-before(format-number($reward, '0.00','de'),'.')"/>
                </fo:inline>
                <xsl:if test="substring-after(format-number($reward, '0.00','de'),'.') != '00'">
                    <fo:inline font-size="{$fontSize * 0.6}pt" vertical-align="top">
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="substring-after(format-number($reward, '0.00','de'),'.')"/>
                    </fo:inline>
                </xsl:if>
            </fo:block>
        </xsl:when>

        <xsl:when test="$promotype = '3_FOR_X'">

            <xsl:variable name="xsave_amount">
                <xsl:choose>
                    <xsl:when test="string-length(substring-after(substring-before($bul_two, ' FOR '),' ')) &gt; 0">
                        <xsl:value-of select="substring-after(substring-before($bul_two, ' FOR '),' ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="substring-before($bul_two, ' FOR ')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="xsave_save">
                <xsl:choose>
                    <xsl:when test="string-length(substring-before(substring-after($bul_two, ' FOR '),' ')) &gt; 0">
                        <xsl:value-of select="translate(substring-before(substring-after($bul_two, ' FOR '),' '), '£', '')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="translate(substring-after($bul_two, ' FOR '), '£', '')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <fo:block font-size="{$fontSize * 0.6}pt">
                <xsl:value-of select="$xsave_amount"/>
                <xsl:text> for</xsl:text>
            </fo:block>
            <fo:block>
                <fo:inline font-size="{$fontSize * 0.6}pt" vertical-align="top">
                    <xsl:text>£</xsl:text>
                </fo:inline>
                <fo:inline vertical-align="top">
                    <xsl:value-of select="substring-before(format-number($xsave_save, '0.00','de'),'.')"/>
                </fo:inline>
                <xsl:if test="substring-after(format-number($xsave_save, '0.00','de'),'.') != '00'">
                    <fo:inline font-size="{$fontSize * 0.6}pt" vertical-align="top">
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="substring-after(format-number($xsave_save, '0.00','de'),'.')"/>
                    </fo:inline>
                </xsl:if>
            </fo:block>
        </xsl:when>

        <xsl:when test="$promotype = '2_AND_3_FOR'">

            <xsl:variable name="xsave_amount">
                <xsl:choose>
                    <xsl:when test="string-length(substring-after(substring-before($bul_two, ' FOR '),' ')) &gt; 0">
                        <xsl:value-of select="substring-after(substring-before($bul_two, ' FOR '),' ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="substring-before($bul_two, ' FOR ')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="xsave_save">
                <xsl:choose>
                    <xsl:when test="string-length(substring-before(substring-after($bul_two, ' FOR '),' ')) &gt; 0">
                        <xsl:value-of select="translate(substring-before(substring-after($bul_two, ' FOR '),' '), '£', '')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="translate(substring-after($bul_two, ' FOR '), '£', '')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="xsave_amount_2">
                <xsl:choose>
                    <xsl:when test="string-length(substring-after(substring-before($bul_two_2, ' FOR '),' ')) &gt; 0">
                        <xsl:value-of select="substring-after(substring-before($bul_two_2, ' FOR '),' ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="substring-before($bul_two_2, ' FOR ')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="xsave_save_2">
                <xsl:choose>
                    <xsl:when test="string-length(substring-before(substring-after($bul_two_2, ' FOR '),' ')) &gt; 0">
                        <xsl:value-of select="translate(substring-before(substring-after($bul_two_2, ' FOR '),' '), '£', '')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="translate(substring-after($bul_two_2, ' FOR '), '£', '')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <fo:table>
            <fo:table-body>
            <fo:table-row>
            <fo:table-cell>
                <fo:block font-size="{$fontSize * 0.3}pt">
                    <xsl:value-of select="$xsave_amount"/>
                    <xsl:text> for</xsl:text>
                </fo:block>
                <fo:block>
                    <fo:inline font-size="{$fontSize * 0.3}pt" vertical-align="top">
                        <xsl:text>£</xsl:text>
                    </fo:inline>
                    <fo:inline vertical-align="top"  font-size="{$fontSize * 0.6}pt">
                        <xsl:value-of select="substring-before(format-number($xsave_save, '0.00','de'),'.')"/>
                    </fo:inline>
                    <xsl:if test="substring-after(format-number($xsave_save, '0.00','de'),'.') != '00'">
                        <fo:inline font-size="{$fontSize * 0.3}pt" vertical-align="top">
                            <xsl:text>.</xsl:text>
                            <xsl:value-of select="substring-after(format-number($xsave_save, '0.00','de'),'.')"/>
                        </fo:inline>
                    </xsl:if>
                </fo:block>
            </fo:table-cell>

            <fo:table-cell border-left="solid 2pt #FFFFFF">
            <fo:block font-size="{$fontSize * 0.3}pt">
                <xsl:value-of select="$xsave_amount_2"/>
                <xsl:text> for</xsl:text>
            </fo:block>
            <fo:block>
                <fo:inline font-size="{$fontSize * 0.3}pt" vertical-align="top">
                    <xsl:text>£</xsl:text>
                </fo:inline>
                <fo:inline vertical-align="top"  font-size="{$fontSize * 0.6}pt">
                    <xsl:value-of select="substring-before(format-number($xsave_save_2, '0.00','de'),'.')"/>
                </fo:inline>
                <xsl:if test="substring-after(format-number($xsave_save_2, '0.00','de'),'.') != '00'">
                    <fo:inline font-size="{$fontSize * 0.3}pt" vertical-align="top">
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="substring-after(format-number($xsave_save_2, '0.00','de'),'.')"/>
                    </fo:inline>
                </xsl:if>
            </fo:block>
            </fo:table-cell>

            </fo:table-row>
            </fo:table-body>
            </fo:table>
        </xsl:when>

        <xsl:when test="$promotype = 'BOGSHP'">
            <fo:block font-size="{$fontSize * 0.3}pt">
                <xsl:text>buy 1 get 2nd</xsl:text>
            </fo:block>
                <xsl:choose>
                <xsl:when test="$is_doublebanner = 1">
                    <fo:block font-size="{$fontSize * 0.4}pt" line-height="0.9">
                        <xsl:text>half price</xsl:text>
                    </fo:block>
                </xsl:when>
                <xsl:otherwise>
                    <fo:block font-size="{$fontSize * 0.6}pt" line-height="0.9">
                        <xsl:text>half&#xA;price</xsl:text>
                    </fo:block>
                </xsl:otherwise>
                </xsl:choose>
        </xsl:when>

        <xsl:when test="$promotype = 'PERCENT_OFF'">
            <xsl:choose>
                <xsl:when test="string-length($reward) &gt; 7 or $offer_qualify_qty &gt; 1">
                    <fo:block font-size="{$fontSize * 0.3}pt">
                        <xsl:text>buy </xsl:text>
                        <xsl:value-of select="$offer_qualify_qty"/>
                        <xsl:text> save</xsl:text>
                    </fo:block>
                    <fo:block>
                        <xsl:value-of select="substring-before(format-number($reward, '0.00','de'),'.')"/>
                        <xsl:text>%</xsl:text>
                    </fo:block>
                </xsl:when>
                <xsl:otherwise>

                    <xsl:variable name="pound" select="substring-before(format-number($now_price, '0.00','de'), '.')"/>
                    <xsl:variable name="pence" select="substring(substring-after(format-number($now_price, '0.00','de'), '.'), 1, 2)"/>

                    <fo:block font-weight="bold">
                        <fo:inline font-size="{$fontSize * 0.4}pt" vertical-align="80%">
                            <xsl:if test="$is_offer = 1 and $bul_two = 'ONLY'">
                                <xsl:text>only </xsl:text>
                            </xsl:if>
                            <xsl:text>£</xsl:text>
                        </fo:inline>
                        <fo:inline vertical-align="top" font-size="{$fontSize * 1}pt">
                            <xsl:value-of select="$pound"/>
                        </fo:inline>
                        <xsl:if test="$pence != '00'">
                            <fo:inline font-size="{$fontSize * 0.4}pt" vertical-align="80%">
                                <xsl:text>.</xsl:text>
                                <xsl:value-of select="$pence"/>
                            </fo:inline>
                        </xsl:if>
                    </fo:block>
                    <fo:block font-weight="bold" font-size="{$fontSize * 0.25}pt">
                        <xsl:value-of select="$base_price"/>
                    </fo:block>                   
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        
        <xsl:when test="$promotype = 'GROUP_PROMO'">
            <fo:block font-size="{$fontSize * 0.5}pt" wrap-option="wrap" hyphenate="true">
                <xsl:choose>
                    <xsl:when test="$detected_group_promo != 'NONE'">
                        <xsl:value-of select="$detected_group_promo"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="titleCaseMe">
                            <xsl:with-param name="text" select="$bul_two"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:block>
        </xsl:when>

        <xsl:otherwise>
            <fo:block font-size="{$fontSize * 0.3}pt">
                <xsl:text>NOT&#xA;IMPLEMENTED</xsl:text>
            </fo:block>
            <fo:block font-size="{$fontSize * 0.3}pt">
                <xsl:value-of select="$offer_type"/>
            </fo:block>
            <fo:block font-size="{$fontSize * 0.3}pt">
                <xsl:value-of select="$bul_two"/>
            </fo:block>
        </xsl:otherwise>
    </xsl:choose>
    </fo:block-container>

    <xsl:if test="$is_big_starbuy = 1">
        <fo:block-container 
            position="absolute" 
            top="0px"
            left="0px"
            height="{$height}px" 
            width="{$width}px" 
            background-image="{$starbuy_full_148x148}" 
            background-repeat="no-repeat">
            <fo:block font-size="{$fontSize * 0.25}pt">
            </fo:block>
        </fo:block-container>
    </xsl:if>

    </fo:block-container>

    </xsl:template>


    <xsl:template name="productDescription">
    <xsl:param name="fontSize"/>
    <xsl:param name="top"/>
    <xsl:param name="left"/>
    <xsl:param name="width"/>
    <xsl:param name="height"/>
    <xsl:param name="linebreak" select="'preserve'"/>

    <fo:block-container position="absolute" 
    left="{$left}px" 
    top="{$top}px" 
    width="{$width}px" 
    height="{$height}px"
    text-align="left"
    font-size="{$fontSize}pt" 
    font-weight="normal"
    linefeed-treatment="{$linebreak}">

    <!--
        <fo:block font-weight="bold">
            <xsl:attribute name="font-size">
                 <xsl:call-template name="getTextFit">
                    <xsl:with-param name="text" select="$brand"/>
                    <xsl:with-param name="fontWeight" select="'2.0f'"/>
                    <xsl:with-param name="fontFamily" select="$default_font"/>
                    <xsl:with-param name="maxSize" select="$fontSize"/>
                    <xsl:with-param name="minSize" select="10"/>
                    <xsl:with-param name="maxWidth" select="$width"/>
                 </xsl:call-template>
            </xsl:attribute>
            <xsl:value-of select="$brand"/>
        </fo:block>

        <fo:block font-size="{$fontSize * 0.7}pt" wrap-option="wrap">
                <xsl:attribute name="font-size">
                 <xsl:call-template name="getTextFit">
                    <xsl:with-param name="text" select="$desc"/>
                    <xsl:with-param name="fontFamily" select="$default_font"/>
                    <xsl:with-param name="maxSize" select="$fontSize * 0.7"/>
                    <xsl:with-param name="minSize" select="10"/>
                    <xsl:with-param name="maxWidth" select="2 * $width"/>
                 </xsl:call-template>
            </xsl:attribute>
            <xsl:value-of select="$desc"/>
        </fo:block>
    -->

        <fo:block wrap-option="wrap" line-height="1.0">
            <xsl:attribute name="font-size">
                 <xsl:call-template name="getTextFit">
                    <xsl:with-param name="text" select="$brand"/>
                    <xsl:with-param name="fontWeight" select="'2.0f'"/>
                    <xsl:with-param name="fontFamily" select="$default_font"/>
                    <xsl:with-param name="maxSize" select="$fontSize"/>
                    <xsl:with-param name="minSize" select="10"/>
                    <xsl:with-param name="maxWidth" select="$width * 2"/>
                 </xsl:call-template>
            </xsl:attribute>
            <xsl:value-of select="$desc_short"/>
        </fo:block>

    </fo:block-container>

    </xsl:template>


    <xsl:template name="priceBig">
    <xsl:param name="fontSize"/>
    <xsl:param name="top"/>
    <xsl:param name="left"/>
    <xsl:param name="width"/>
    <xsl:param name="height"/>
    <xsl:param name="linebreak" select="'preserve'"/>

    <fo:block-container position="absolute" 
    left="{$left}px" 
    top="{$top}px" 
    width="{$width}px" 
    height="{$height}px"
    text-align="right"
    font-size="{$fontSize}pt" 
    font-family="{$price_font}"
    font-weight="normal"
    linefeed-treatment="{$linebreak}">

        <xsl:variable name="price">
            <xsl:choose>
                <xsl:when test="$members_only = 1
                                and ($promotype = 'PRICE_CUT'
                                    or $promotype ='PERCENT_OFF')">
                    <xsl:value-of select='$new_was_price'/>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:value-of select='$now_price'/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="pound" select="substring-before(format-number($price, '0.00','de'), '.')"/>
        <xsl:variable name="pence" select="substring(substring-after(format-number($price, '0.00','de'), '.'), 1, 2)"/>

        <fo:block font-weight="bold">
            <fo:inline font-size="{$fontSize * 0.4}pt" vertical-align="80%">
                <xsl:if test="$is_offer = 1 and $promotype = 'ONLY'">
                    <xsl:text>only </xsl:text>
                </xsl:if>
                <xsl:text>£</xsl:text>
            </fo:inline>
            <fo:inline vertical-align="top">
                <xsl:value-of select="$pound"/>
            </fo:inline>
            <fo:inline font-size="{$fontSize * 0.4}pt" vertical-align="80%">
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$pence"/>
            </fo:inline>
        </fo:block>
    </fo:block-container>

    </xsl:template>

    <xsl:template name="basePrice">
    <xsl:param name="fontSize"/>
    <xsl:param name="top"/>
    <xsl:param name="left"/>
    <xsl:param name="width"/>
    <xsl:param name="height"/>
    <xsl:param name="linebreak" select="'preserve'"/>

    <fo:block-container position="absolute" 
    left="{$left}px" 
    top="{$top}px" 
    width="{$width}px" 
    height="{$height}px"
    text-align="right"
    font-size="{$fontSize}pt" 
    font-weight="normal"
    linefeed-treatment="{$linebreak}"
    wrap-option="wrap"
    line-height="1.1">

        <fo:block>
            <xsl:choose>
                <xsl:when test="$promotype = 'BOGOF'
                                or $promotype = '3_FOR_2'
                                or $promotype = '2_FOR_X'
                                or $promotype = '2_AND_3_FOR'
                                or $promotype = '3_FOR_X'
                                or $promotype = 'BOGSHP'
                                or ($members_only = 1
                                and ($promotype = 'PRICE_CUT'
                                    or $promotype ='PERCENT_OFF'))">
                    <xsl:value-of select="$was_base_price"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$base_price"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>

    </fo:block-container>

    </xsl:template>


    <xsl:template name="smallPriceAndBase">
    <xsl:param name="fontSize"/>
    <xsl:param name="top"/>
    <xsl:param name="left"/>
    <xsl:param name="width"/>
    <xsl:param name="height"/>
    <xsl:param name="linebreak" select="'preserve'"/>

    <fo:block-container position="absolute" 
    left="{$left}px" 
    top="{$top}px" 
    width="{$width}px" 
    height="{$height}px"
    text-align="center"
    font-size="{$fontSize}pt" 
    font-family="{$price_font}"
    font-weight="normal"
    linefeed-treatment="{$linebreak}">


        <fo:block font-weight="bold" font-size="{$fontSize * 0.75}pt" font-family="{$default_font}">
            <xsl:text>non-members price</xsl:text>
        </fo:block>
        <fo:block font-weight="bold">
            <xsl:text>£</xsl:text>
            <xsl:value-of select="format-number($new_was_price, '0.00','de')"/>
        </fo:block>
        <fo:block font-size="{$fontSize * 0.6}pt" font-family="{$default_font}">
            <xsl:value-of select="$was_base_price"/>
        </fo:block>
    </fo:block-container>

    </xsl:template>

    <xsl:template name="infoLine">
    <xsl:param name="fontSize"/>
    <xsl:param name="top"/>
    <xsl:param name="left"/>
    <xsl:param name="width"/>
    <xsl:param name="height"/>
    <xsl:param name="linebreak" select="'preserve'"/>

    <fo:block-container position="absolute" 
    left="{$left}px" 
    top="{$top}px" 
    width="{$width}px" 
    height="{$height}px"
    text-align="left"
    font-size="{$fontSize}pt" 
    font-weight="normal"
    linefeed-treatment="{$linebreak}"
    wrap-option="wrap">

        <fo:block white-space="pre">
            <xsl:value-of select="$barcode"/>
            <xsl:if test="$is_offer = 1">
                <xsl:text>   Ts&amp;Cs apply</xsl:text>
            </xsl:if>
        </fo:block>

    </fo:block-container>

    </xsl:template>

    <xsl:template name="Barcode">
    <xsl:param name="top"/>
    <xsl:param name="left"/>
    <xsl:param name="barcode" select="'123456'"/>
    <xsl:param name="rotate" select="'0'"/>
    <xsl:param name="factor" select="'1'"/>
    <xsl:param name="height" select="'8'"/>
    <xsl:param name="align" select="'left'"/>
    

    <fo:block-container position="absolute" 
    left="{$left}px" 
    top="{$top}px"
    text-align="{$align}"
    reference-orientation="{$rotate}">

		<fo:block>
            <xsl:if test="string-length($barcode) &gt; 0">
			<fo:instream-foreign-object padding="8px">
				<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$barcode}">
					<barcode:code128>
						<barcode:height><xsl:value-of select="$height"/></barcode:height>
                        <xsl:choose>
                        <xsl:when test="$factor = '2'">
						    <barcode:module-width>0.027777778in</barcode:module-width>
                        </xsl:when>
                        <xsl:otherwise>
						    <barcode:module-width>0.013888889in</barcode:module-width>
                        </xsl:otherwise>
                        </xsl:choose>
						<barcode:quiet-zone enabled="false"></barcode:quiet-zone>
						<barcode:human-readable>
						<barcode:placement>none</barcode:placement>
						</barcode:human-readable>
						<barcode:wide-factor>3</barcode:wide-factor>
					</barcode:code128>
				</barcode:barcode>
			</fo:instream-foreign-object>
            </xsl:if>
		</fo:block>

    </fo:block-container>
    </xsl:template>


    <xsl:template name="LAYOUT29">

        <xsl:call-template name="productDescription">
            <xsl:with-param name="top" select="5"/>
            <xsl:with-param name="left" select="5 + $is_offer_box * 148"/>
            <xsl:with-param name="width" select="378 - $is_offer_box * 148"/>
            <xsl:with-param name="height" select="60"/>
            <xsl:with-param name="fontSize" select="29 - 6 * $is_offer_box - 5 * $is_offer"/>
        </xsl:call-template>

        <xsl:if test="$is_offer_box = 1">
            <xsl:call-template name="offerBox">
                <xsl:with-param name="top" select="0"/>
                <xsl:with-param name="left" select="0"/>
                <xsl:with-param name="width" select="148"/>
                <xsl:with-param name="height" select="148"/>
                <xsl:with-param name="fontSize" select="60"/>
            </xsl:call-template>
        </xsl:if>

        <xsl:choose>
            <xsl:when test="$members_price = 1">
                <xsl:call-template name="smallPriceAndBase">
                    <xsl:with-param name="top" select="88"/>
                    <xsl:with-param name="left" select="135"/>
                    <xsl:with-param name="width" select="248"/>
                    <xsl:with-param name="height" select="100"/>
                    <xsl:with-param name="fontSize" select="22"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="priceBig">
                    <xsl:with-param name="top" select="55"/>
                    <xsl:with-param name="left" select="100"/>
                    <xsl:with-param name="width" select="279"/>
                    <xsl:with-param name="height" select="100"/>
                    <xsl:with-param name="fontSize" select="90"/>
                </xsl:call-template>

                <xsl:call-template name="basePrice">
                    <xsl:with-param name="top" select="135"/>
                    <xsl:with-param name="left" select="100"/>
                    <xsl:with-param name="width" select="279"/>
                    <xsl:with-param name="height" select="100"/>
                    <xsl:with-param name="fontSize" select="13"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:call-template name="infoLine">
            <xsl:with-param name="top" select="153"/>
            <xsl:with-param name="left" select="5"/>
            <xsl:with-param name="width" select="150"/>
            <xsl:with-param name="height" select="15"/>
            <xsl:with-param name="fontSize" select="12"/>
        </xsl:call-template>

        <xsl:call-template name="Barcode">
            <xsl:with-param name="top" select="143"/>
            <xsl:with-param name="left" select="100"/>
            <xsl:with-param name="factor" select="2"/>
            <xsl:with-param name="align" select="'right'"/>
            <xsl:with-param name="barcode" select="$barcode"/>
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>
