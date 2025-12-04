# Deploy Fake News Detector to Free Hosting

Your fake-news detector can be deployed for FREE on multiple platforms. Choose your preferred option below.

## 🚀 Quick Deployment Options

### Option 1: Heroku (Free Tier - EASIEST)

**Heroku is SHUTTING DOWN free tier on November 28, 2022.** Use alternatives instead.

### Option 2: Vercel (Recommended for Free)

Vercel offers unlimited free deployments with generous limits.

**Prerequisites:**
- GitHub account (free)
- Vercel account (free at vercel.com)
- Git installed

**Steps:**

1. **Push to GitHub**
```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR_USERNAME/fake-news-detector.git
git push -u origin main
```

2. **Deploy to Vercel**
```bash
npm i -g vercel
vercel
```

3. **Configure Environment (if needed)**
   - Select your GitHub repo
   - Vercel auto-detects Flask app
   - Deploy!

**Free Tier Benefits:**
- Unlimited deployments
- Custom domains
- Auto HTTPS
- Built-in analytics

---

### Option 3: Google Cloud Run (Free Credits)

Google offers $300 free credits for new users (12 months).

**Prerequisites:**
- Google Cloud account
- gcloud CLI installed

**Steps:**

1. **Create app.yaml**
```yaml
runtime: python311
entrypoint: gunicorn -b :$PORT app:app

env: standard
```

2. **Deploy**
```bash
gcloud app deploy
```

3. **Access your app**
```
https://YOUR_PROJECT_ID.appspot.com
```

**Free Tier:** $300 credits + 28 instance hours/month free

---

### Option 4: PythonAnywhere (Free Tier)

PythonAnywhere is specifically designed for Python web apps.

**Steps:**

1. Sign up at pythonanywhere.com (free account)
2. Upload files via web interface or Git
3. Configure WSGI file
4. Restart web app
5. Access at `yourname.pythonanywhere.com`

**Free Tier:** 1 web app + 512MB storage

---

### Option 5: Railway (Most Beginner-Friendly)

Railway is modern and very easy to use.

**Steps:**

1. Go to railway.app
2. Click "New Project"
3. Connect GitHub repo
4. Configure variables if needed
5. Deploy with 1 click

**Free Tier:** $5/month credits (enough for this app)

---

### Option 6: Render (Alternative)

Render is simple and free with some limitations.

**Steps:**

1. Sign up at render.com
2. Create New → Web Service
3. Connect GitHub repo
4. Set Start Command: `gunicorn app:app`
5. Deploy

**Free Tier:** Auto-sleeps after 15 min inactivity, wakes on request

---

## 📋 Recommended Deployment Flow

**Best Option for Beginners:**

1. **Railway** (simplest, $5/month free)
   - Pros: 1-click deployment, generous free tier
   - Cons: Auto-shuts down projects not used for 7 days

2. **Vercel** (best overall)
   - Pros: Unlimited free deployments, custom domain
   - Cons: Requires GitHub

3. **Google Cloud Run** (best for learning)
   - Pros: $300 free credits, production-grade
   - Cons: More complex setup

---

## 🌐 Custom Domain Setup

Once deployed, you can add a FREE domain:

### Free Domain Options:
1. **Freenom** - `.ml`, `.ga`, `.cf` domains (truly free)
2. **Namecheap** - First year free with certain domains
3. **Google Domains** - $12/year (cheapest premium)

### Point Domain to Your App:

**For Vercel:**
- Add domain in Vercel dashboard
- Update DNS records as shown

**For Railway/Google Cloud:**
- Use CNAME record pointing to your app URL

---

## 🔧 Local Testing Before Deployment

**Test locally first:**

```bash
# Install dependencies
pip install -r requirements.txt

# Run app
python app.py

# Visit http://localhost:5000
```

---

## 📊 Comparing Free Platforms

| Platform | Cost | Custom Domain | Uptime | Setup | Support |
|----------|------|---------------|--------|-------|---------|
| **Vercel** | Free | ✅ | 99.99% | ⭐⭐ | Excellent |
| **Railway** | $5 free | ✅ | 99.9% | ⭐ | Good |
| **Render** | Free* | ✅ | 99.9%* | ⭐⭐ | Good |
| **Google Cloud Run** | $300 credit | ✅ | 99.95% | ⭐⭐⭐ | Excellent |
| **PythonAnywhere** | Free | ❌ | 99.9% | ⭐ | Good |
| **Railway** | Free | Limited | 99.9% | ⭐ | Good |

*Render: Spins down after 15 min inactivity

---

## ⚠️ Important Notes

1. **Free Tier Limitations:**
   - May have monthly bandwidth limits
   - Could auto-sleep with inactivity
   - Some have restricted resource usage

2. **Scalability:**
   - For high traffic, consider paid plans
   - This app is lightweight and runs on free tier

3. **Custom Domain:**
   - Get free `.ml` domain from Freenom
   - Or use platform's subdomain

4. **SSL/HTTPS:**
   - All platforms provide free HTTPS
   - Essential for security

---

## 🚀 Deployment Checklist

- [ ] Code committed to GitHub
- [ ] requirements.txt updated with all dependencies
- [ ] `app.py` configured (debug=False for production)
- [ ] Static files organized
- [ ] Environment variables documented
- [ ] Tested locally
- [ ] Account created on hosting platform
- [ ] Repository connected (if using GitHub)
- [ ] Deployment command executed
- [ ] App live and accessible
- [ ] Custom domain configured (optional)

---

## 📞 Troubleshooting

### App Won't Start
```
Check logs: Most platforms have log viewer in dashboard
Verify Python version matches (3.9+)
Ensure all dependencies in requirements.txt
```

### Missing Module Error
```
pip freeze > requirements.txt
Redeploy with updated dependencies
```

### Slow Performance
```
- Use production-grade WSGI server (gunicorn ✅)
- Disable debug mode
- Use transformer=False in production
```

### Domain Not Resolving
```
- Wait 24-48 hours for DNS propagation
- Verify CNAME/A record configuration
- Check platform DNS documentation
```

---

## 💡 Next Steps After Deployment

1. **Test the deployed app** with real URLs
2. **Share with friends** for feedback
3. **Monitor performance** using platform analytics
4. **Upgrade to paid tier** if needed (usually $5-10/month)
5. **Enhance the app** with new features:
   - User authentication
   - Article history
   - Confidence calibration
   - Source verification

---

## 🎉 Congratulations!

Your Fake News Detector is now live on the internet! Share the link with others and help combat misinformation.

**App URL:** `https://your-domain.com`

---

**Questions?** Refer to each platform's documentation or visit their support pages.

Happy deploying! 🚀
