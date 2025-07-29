import fireducks.pandas as pd
import matplotlib.pyplot as plt
from sklearn.metrics import mean_absolute_error
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split


height_weight_path = "./SOCR-HeightWeight.csv"
df = pd.read_csv(height_weight_path)
df.drop(columns="Index")


df = df.rename(columns={"Height(Inches)": "Height", "Weight(Pounds)": "Weight"})

# Working with Height and Weight Dataset
# * Splitting the data


X = df["Height"]
y = df["Weight"]

train_X, test_X, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=1)

# * Linear Regression Model


df.info()


lr_model = LinearRegression()
lr_model.fit(train_X.values.reshape(-1, 1), y_train)

# * Make Predictions


y_pred = lr_model.predict(test_X.values.reshape(-1, 1))
print(y_pred)
# * Calculate Mean Absolute Error

# ## Visualize the results


plt.figure(figsize=(10, 6))
plt.scatter(test_X, y_test, alpha=0.6, label="Actual")
plt.scatter(test_X, y_pred, alpha=0.6, label="Predicted")
plt.xlabel("Heigh(Inches)")
plt.ylabel("Weight(Pounds)")
plt.title("Linear Regression: Height vs Weight")
plt.legend()
plt.show()
