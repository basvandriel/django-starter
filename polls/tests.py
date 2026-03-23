from django.test import TestCase
from django.urls import reverse


class IndexViewTest(TestCase):
    def test_index_returns_200(self):
        response = self.client.get(reverse("index"))
        self.assertEqual(response.status_code, 200)

    def test_index_content(self):
        response = self.client.get(reverse("index"))
        self.assertIn(b"polls index", response.content)
