#include <iostream>
#include <queue>
#include <vector>
#include <map>

using namespace std;

struct Node {
    char data;
    int freq;
    Node *left, *right;
    Node(char data, int freq) : data(data), freq(freq), left(NULL), right(NULL) {}
};

struct compare {
    bool operator()(Node* l, Node* r) {
        return l->freq > r->freq;
    }
};

Node* buildHuffmanTree(map<char, int>& freqMap) {
    priority_queue<Node*, vector<Node*>, compare> minHeap;

    for (auto pair : freqMap) {
        minHeap.push(new Node(pair.first, pair.second));
    }

    while (minHeap.size() != 1) {
        Node *left = minHeap.top(); minHeap.pop();
        Node *right = minHeap.top(); minHeap.pop();

        int sum = left->freq + right->freq;

        Node* newNode = new Node('\0', sum); 
        newNode->left = left;
        newNode->right = right;

        minHeap.push(newNode);
    }

    return minHeap.top();
}

void printHuffmanCodes(Node* root, string str) {
    if (root == NULL)
        return;

    if (root->data != '\0')
        cout << root->data << ": " << str << "\n";

    printHuffmanCodes(root->left, str + "0");
    printHuffmanCodes(root->right, str + "1");
}

int main() {
    int n;
    cout << "Enter the number of characters: ";
    cin >> n;

    map<char, int> freqMap;
    for (int i = 0; i < n; i++) {
        char character;
        int frequency;
        cout << "Enter character and frequency: ";
        cin >> character >> frequency;
        freqMap[character] = frequency;
    }

    Node* root = buildHuffmanTree(freqMap);
    cout << "Huffman Codes are:\n";
    printHuffmanCodes(root, "");

    return 0;
}
