import js

import numpy as np 

from sklearn import datasets
from sklearn.model_selection import train_test_split

from sklearn.neighbors import KNeighborsClassifier

import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap
import seaborn as sns
from sklearn.inspection import DecisionBoundaryDisplay

from sklearn.metrics import accuracy_score

cmap_light = ListedColormap(["orange", "cyan", "cornflowerblue"])
cmap_bold = ["darkorange", "c", "darkblue"]

iris = datasets.load_iris()

# We only take the first two features.
X = iris.data[:, :2]
y = iris.target


def classify_and_plot():
    k_neighbors = js.document.getElementsByName("neighbors")
    for element in k_neighbors:
        if element.checked:
            k = int(element.value)
            break
    
    paragraph = Element("K")
    paragraph.write(f"Number of K: {k}")
    
    clf = KNeighborsClassifier(n_neighbors=k)
        
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=1234)
    
    clf.fit(X_train, y_train)
    y_pred = clf.predict(X_test)
    
    acc = accuracy_score(y_test, y_pred)
    
    paragraph = Element("accuracy")
    paragraph.write(f"Accuracy: {acc}")
    
    fig, ax = plt.subplots()
    DecisionBoundaryDisplay.from_estimator(
        clf,
        X,
        cmap=cmap_light,
        ax=ax,
        response_method="predict",
        plot_method="pcolormesh",
        xlabel=iris.feature_names[0],
        ylabel=iris.feature_names[1],
        shading="auto",
    )

    # Plot also the training points
    sns.scatterplot(
        x=X[:, 0],
        y=X[:, 1],
        hue=iris.target_names[y],
        palette=cmap_bold,
        alpha=1.0,
        edgecolor="black",
    )
    plt.title(
        "3-Class classification (k = %i)" % (k)
    )
    
    display(fig, target="graph-area", append=False)