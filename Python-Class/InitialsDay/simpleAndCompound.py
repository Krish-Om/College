def simple_interest(p, r, t):
    return (p * t * r) / 100


def compound_interest(
    p,
    r,
    t,
):
    return p * ((1 + (r / 100) ** t) - 1)


def compound_amount(p, r, t):
    return p * ((1 + r / 100) ** t)


principle = float(input("Enter the principle amount:"))
rate = float(input("Enter the rate :"))
time = float(input("Enter the time:"))

diff = abs(
    simple_interest(principle, rate, time)
    - compound_interest(principle, rate, time)
    - compound_amount(principle, rate, time)
)
print(f"SI:{simple_interest(p=principle,r=rate,t=time)}")
print(f"CI:{compound_interest(p=principle,r=rate,t=time)}")
print(f"CA:{compound_amount(p=principle,t=time,r=rate)}")

print(f"The difference: {diff}")

print("Difference:",diff)


