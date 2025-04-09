import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/apptheme.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/screens/starting_screens/splash_screen.dart';
import 'package:prime_app/service/firestore_service.dart';
import 'package:prime_app/service/notification_service.dart';
import 'package:prime_app/service/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefService.init();
  await NotificationService().initNotifications();
  // await FirestoreService().renameDocument('mcqs', 'gk part 1', 'accounts jobs');
  // await dataEntry();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  FirebaseMessaging.instance.subscribeToTopic("all");
  String? deviceId = await SharedPrefService().getDeviceId();
  print(deviceId);
  if (!(deviceId!.isEmpty)) {
    print(
        "Trying to delete expire courses registerd on this device with device id $deviceId");
    await FirestoreService().isExpired(deviceId: deviceId);
  }

  runApp(GetMaterialApp(
    theme: AppTheme.lightTheme,
    getPages: AppRoutes.routes,
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseMessaging.instance.subscribeToTopic("all");
  print('background message ${message.notification!.title}');
}

// Map<int, List<Map<String, dynamic>>> mcqsByPage = {
//   41: [
//     {
//       "question": "Faithful representation excludes:",
//       "options": ["Ambiguities that cannot be reliably measured.", "All estimates.", "Legal forms of transactions.", "Historical data."],
//       "answer": "Ambiguities that cannot be reliably measured."
//     },
//     {
//       "question": "Prudence in financial statements means:",
//       "options": ["Avoiding overstatement of assets or profits.", "Ignoring all risks.", "Maximizing reported earnings.", "Excluding liabilities."],
//       "answer": "Avoiding overstatement of assets or profits."
//     },
//     {
//       "question": "The materiality concept depends on:",
//       "options": ["The size and nature of the item.", "The company's location.", "Employee opinions.", "Competitor actions."],
//       "answer": "The size and nature of the item."
//     },
//     {
//       "question": "Comparability is hindered by:",
//       "options": ["Inconsistent accounting policies.", "Detailed disclosures.", "Neutrality.", "Completeness."],
//       "answer": "Inconsistent accounting policies."
//     },
//     {
//       "question": "Which characteristic ensures financial statements are not misleading?",
//       "options": ["Completeness", "Complexity", "Optimism", "Exclusivity"],
//       "answer": "Completeness"
//     },
//     {
//       "question": "Internal goodwill is often excluded from financial statements due to:",
//       "options": ["Difficulty in measurement.", "Tax regulations.", "Employee objections.", "Competitor pressure."],
//       "answer": "Difficulty in measurement."
//     },
//     {
//       "question": "Bias in financial statements can lead to:",
//       "options": ["Pre-determined results influencing users.", "Higher profits.", "Better employee morale.", "Increased market share."],
//       "answer": "Pre-determined results influencing users."
//     },
//     {
//       "question": "The substance over legal form principle ensures:",
//       "options": ["Transactions reflect economic reality.", "Legal compliance is ignored.", "Only cash transactions are recorded.", "Estimates are excluded."],
//       "answer": "Transactions reflect economic reality."
//     },
//     {
//       "question": "Which user group is interested in long-term supply stability?",
//       "options": ["Customers", "Employees", "Tax authorities", "Management"],
//       "answer": "Customers"
//     },
//     {
//       "question": "The Securities and Exchange Commission is an example of:",
//       "options": ["Regulatory Authorities", "Internal Users", "Creditors", "Investors"],
//       "answer": "Regulatory Authorities"
//     },
//     {
//       "question": "Financial statements help management in:",
//       "options": ["Decision-making and planning.", "Setting tax rates.", "Designing products.", "Hiring employees."],
//       "answer": "Decision-making and planning."
//     },
//     {
//       "question": "Which of the following is a qualitative characteristic of financial statements?",
//       "options": ["Relevance", "Profitability", "Liquidity", "Solvency"],
//       "answer": "Relevance"
//     },
//     {
//       "question": "The term \"neutrality\" is closely related to:",
//       "options": ["Freedom from bias.", "Completeness.", "Understandability.", "Comparability."],
//       "answer": "Freedom from bias."
//     },
//     {
//       "question": "Omission of material information makes financial statements:",
//       "options": ["Unreliable and irrelevant.", "Easier to understand.", "More comparable.", "Neutral."],
//       "answer": "Unreliable and irrelevant."
//     },
//     {
//       "question": "Consistency in accounting policies enhances:",
//       "options": ["Comparability.", "Relevance.", "Materiality.", "Prudence."],
//       "answer": "Comparability."
//     },
//     {
//       "question": "Which user group relies on financial statements to confirm predictions?",
//       "options": ["Investors", "Employees", "Suppliers", "Management"],
//       "answer": "Investors"
//     },
//     {
//       "question": "The primary purpose of financial statements is to:",
//       "options": ["Provide useful information to users.", "Reduce tax liabilities.", "Increase sales.", "Attract competitors."],
//       "answer": "Provide useful information to users."
//     },
//     {
//       "question": "Which characteristic requires financial statements to be free from errors?",
//       "options": ["Reliability", "Relevance", "Understandability", "Comparability"],
//       "answer": "Reliability"
//     },
//     {
//       "question": "Employees use financial statements to assess:",
//       "options": ["Company profitability and job security.", "Tax evasion.", "Market competition.", "Product quality."],
//       "answer": "Company profitability and job security."
//     },
//     {
//       "question": "Which of the following is NOT a characteristic of useful accounting information?",
//       "options": ["Complexity", "Relevance", "Reliability", "Comparability"],
//       "answer": "Complexity"
//     },
//   ],
//   42: [
//     {
//       "question": "Financial statements are prepared to meet the needs of:",
//       "options": ["Both internal and external users.", "Only management.", "Only shareholders.", "Only government."],
//       "answer": "Both internal and external users."
//     },
//     {
//       "question": "The term \"faithful representation\" is associated with:",
//       "options": ["Accuracy and substance of information.", "Legal compliance.", "Employee satisfaction.", "Marketing strategies."],
//       "answer": "Accuracy and substance of information."
//     },
//     {
//       "question": "Which user group is interested in the financial health of a supplier?",
//       "options": ["Customers", "Employees", "Tax authorities", "Management"],
//       "answer": "Customers"
//     },
//     {
//       "question": "Regulatory authorities protect the interests of:",
//       "options": ["Stakeholders relying on financial statements.", "Only shareholders.", "Only creditors.", "Only management."],
//       "answer": "Stakeholders relying on financial statements."
//     },
//     {
//       "question": "The concept of prudence prevents:",
//       "options": ["Overstatement of financial performance.", "Understatement of liabilities.", "Disclosure of all estimates.", "Comparison with prior years."],
//       "answer": "Overstatement of financial performance."
//     },
//     {
//       "question": "What is the primary purpose of adjusting entries?",
//       "options": ["To record daily transactions", "To ensure financial statements reflect accurate revenues and expenses for the period", "To close temporary accounts", "To prepare tax returns"],
//       "answer": "To ensure financial statements reflect accurate revenues and expenses for the period"
//     },
//     {
//       "question": "Adjusting entries typically involve which types of accounts?",
//       "options": ["Two balance sheet accounts", "Two income statement accounts", "One income statement account and one balance sheet account", "Two permanent accounts"],
//       "answer": "One income statement account and one balance sheet account"
//     },
//     {
//       "question": "Why might an adjusting entry be needed for prepaid insurance?",
//       "options": ["To record the full payment as an expense", "To expense only the portion of insurance used during the period", "To reduce the liability account", "To close the insurance account"],
//       "answer": "To expense only the portion of insurance used during the period"
//     },
//     {
//       "question": "An electricity bill of Rs. 20,000 is payable at year-end. What is the adjusting entry?",
//       "options": ["Debit Electricity Expense; Credit Cash", "Debit Electricity Expense; Credit Utilities Payable", "Debit Utilities Payable; Credit Electricity Expense", "Debit Cash; Credit Electricity Expense"],
//       "answer": "Debit Electricity Expense; Credit Utilities Payable"
//     },
//     {
//       "question": "Salaries accrued at year-end are recorded as:",
//       "options": ["Debit Salaries Payable; Credit Salaries Expense", "Debit Salaries Expense; Credit Salaries Payable", "Debit Cash; Credit Salaries Expense", "Debit Salaries Expense; Credit Cash"],
//       "answer": "Debit Salaries Expense; Credit Salaries Payable"
//     },
//     {
//       "question": "Depreciation on an office building is recorded as:",
//       "options": ["Debit Accumulated Depreciation; Credit Depreciation Expense", "Debit Depreciation Expense; Credit Accumulated Depreciation", "Debit Office Building; Credit Depreciation Expense", "Debit Depreciation Expense; Credit Office Building"],
//       "answer": "Debit Depreciation Expense; Credit Accumulated Depreciation"
//     },
//     {
//       "question": "Which of the following is NOT a characteristic of adjusting entries?",
//       "options": ["They are made at the end of the accounting period", "They involve one income statement and one balance sheet account", "They are used to record daily transactions", "They ensure accurate financial statements"],
//       "answer": "They are used to record daily transactions"
//     },
//     {
//       "question": "Adjusting entries are necessary because:",
//       "options": ["They simplify the accounting process", "Some revenues and expenses are not recorded during the period", "They replace closing entries", "They are required by tax laws"],
//       "answer": "Some revenues and expenses are not recorded during the period"
//     },
//     {
//       "question": "Prepaid expenses are initially recorded as:",
//       "options": ["Expenses", "Assets", "Liabilities", "Revenues"],
//       "answer": "Assets"
//     },
//     {
//       "question": "An adjusting entry for unearned revenue would involve:",
//       "options": ["Debit Unearned Revenue; Credit Revenue", "Debit Revenue; Credit Unearned Revenue", "Debit Cash; Credit Unearned Revenue", "Debit Unearned Revenue; Credit Cash"],
//       "answer": "Debit Unearned Revenue; Credit Revenue"
//     },
//     {
//       "question": "What is the purpose of closing entries?",
//       "options": ["To adjust account balances", "To transfer temporary account balances to permanent accounts", "To record new transactions", "To prepare financial statements"],
//       "answer": "To transfer temporary account balances to permanent accounts"
//     },
//     {
//       "question": "Which of the following is a temporary account?",
//       "options": ["Retained Earnings", "Salaries Expense", "Accumulated Depreciation", "Prepaid Insurance"],
//       "answer": "Salaries Expense"
//     },
//     {
//       "question": "The first step in the closing process is to close:",
//       "options": ["Expense accounts", "Revenue accounts", "Dividends accounts", "Income Summary"],
//       "answer": "Revenue accounts"
//     },
//     {
//       "question": "Revenue accounts are closed by:",
//       "options": ["Debiting Revenue; Crediting Income Summary", "Debiting Income Summary; Crediting Revenue", "Debiting Retained Earnings; Crediting Revenue", "Debiting Revenue; Crediting Retained Earnings"],
//       "answer": "Debiting Revenue; Crediting Income Summary"
//     },
//     {
//       "question": "Expense accounts are closed by:",
//       "options": ["Debiting Expense; Crediting Income Summary", "Debiting Income Summary; Crediting Expense", "Debiting Retained Earnings; Crediting Expense", "Debiting Expense; Crediting Retained Earnings"],
//       "answer": "Debiting Income Summary; Crediting Expense"
//     },
//   ],
//   43: [
//     {
//       "question": "The Income Summary account is closed to:",
//       "options": ["Revenue", "Expense", "Retained Earnings", "Dividends"],
//       "answer": "Retained Earnings"
//     },
//     {
//       "question": "Dividends are closed by:",
//       "options": ["Debiting Dividends; Crediting Retained Earnings", "Debiting Retained Earnings; Crediting Dividends", "Debiting Income Summary; Crediting Dividends", "Debiting Dividends; Crediting Income Summary"],
//       "answer": "Debiting Retained Earnings; Crediting Dividends"
//     },
//     {
//       "question": "After closing entries, the balances of temporary accounts are:",
//       "options": ["Transferred to the next period", "Zero", "Reported on the balance sheet", "Adjusted for accruals"],
//       "answer": "Zero"
//     },
//     {
//       "question": "Closing entries ensure that:",
//       "options": ["All accounts are adjusted", "Temporary accounts start the next period with zero balances", "Permanent accounts are reset", "Financial statements are prepared"],
//       "answer": "Temporary accounts start the next period with zero balances"
//     },
//     {
//       "question": "The final step in the closing process is to close:",
//       "options": ["Revenue accounts", "Expense accounts", "Dividends", "Income Summary"],
//       "answer": "Income Summary"
//     },
//     {
//       "question": "Which of the following is recorded in the general journal?",
//       "options": ["Daily cash transactions", "Adjusting and closing entries", "Purchase orders", "Bank reconciliations"],
//       "answer": "Adjusting and closing entries"
//     },
//     {
//       "question": "The general journal is used to record:",
//       "options": ["Only revenue transactions", "Non-routine transactions", "Only expense transactions", "Routine transactions"],
//       "answer": "Non-routine transactions"
//     },
//     {
//       "question": "An example of a general journal entry is:",
//       "options": ["Recording a sale on account", "Recording depreciation expense", "Posting to the ledger", "Preparing a trial balance"],
//       "answer": "Recording depreciation expense"
//     },
//     {
//       "question": "The general journal provides:",
//       "options": ["A summary of all ledger accounts", "A chronological record of transactions", "A list of permanent accounts", "A report of financial ratios"],
//       "answer": "A chronological record of transactions"
//     },
//     {
//       "question": "Which of the following is NOT typically recorded in the general journal?",
//       "options": ["Adjusting entries", "Closing entries", "Cash sales", "Depreciation entries"],
//       "answer": "Cash sales"
//     },
//     {
//       "question": "The balance of the Income Summary account after closing revenues and expenses represents:",
//       "options": ["Total assets", "Net income or net loss", "Total liabilities", "Retained Earnings"],
//       "answer": "Net income or net loss"
//     },
//     {
//       "question": "Accumulated Depreciation is a:",
//       "options": ["Revenue account", "Contra asset account", "Liability account", "Expense account"],
//       "answer": "Contra asset account"
//     },
//     {
//       "question": "Unearned revenue is classified as a:",
//       "options": ["Liability", "Asset", "Expense", "Revenue"],
//       "answer": "Liability"
//     },
//     {
//       "question": "The accounting cycle ends with:",
//       "options": ["Preparing financial statements", "Closing the books", "Recording transactions", "Posting to the ledger"],
//       "answer": "Closing the books"
//     },
//     {
//       "question": "Which account is NOT closed at the end of the accounting period?",
//       "options": ["Salaries Expense", "Retained Earnings", "Revenue", "Dividends"],
//       "answer": "Retained Earnings"
//     },
//     {
//       "question": "Adjusting entries are prepared:",
//       "options": ["At the beginning of the period", "At the end of the period", "During the period", "Only for tax purposes"],
//       "answer": "At the end of the period"
//     },
//     {
//       "question": "The purpose of closing dividends is to:",
//       "options": ["Increase retained earnings", "Decrease retained earnings", "Record dividend payments", "Adjust the dividend account"],
//       "answer": "Decrease retained earnings"
//     },
//     {
//       "question": "Which of the following accounts is permanent?",
//       "options": ["Revenue", "Prepaid Insurance", "Salaries Expense", "Dividends"],
//       "answer": "Prepaid Insurance"
//     },
//     {
//       "question": "Closing entries are prepared:",
//       "options": ["Before adjusting entries", "After adjusting entries", "During the accounting period", "Only for corporations"],
//       "answer": "After adjusting entries"
//     },
//     {
//       "question": "The Income Summary account is used to:",
//       "options": ["Record revenues and expenses", "Summarize net income or loss before closing to Retained Earnings", "Adjust asset accounts", "Record dividends"],
//       "answer": "Summarize net income or loss before closing to Retained Earnings"
//     },
//   ],
//   44: [
//     {
//       "question": "Which of the following is a contra account?",
//       "options": ["Accounts Receivable", "Accumulated Depreciation", "Salaries Payable", "Revenue"],
//       "answer": "Accumulated Depreciation"
//     },
//     {
//       "question": "The entry to close a net loss would include:",
//       "options": ["Debiting Retained Earnings; Crediting Income Summary", "Debiting Income Summary; Crediting Retained Earnings", "Debiting Revenue; Crediting Income Summary", "Debiting Expenses; Crediting Income Summary"],
//       "answer": "Debiting Retained Earnings; Crediting Income Summary"
//     },
//     {
//       "question": "Prepaid expenses are classified as:",
//       "options": ["Assets", "Liabilities", "Revenues", "Expenses"],
//       "answer": "Assets"
//     },
//     {
//       "question": "The adjusting entry for accrued salaries includes:",
//       "options": ["Debiting Salaries Payable; Crediting Salaries Expense", "Debiting Salaries Expense; Crediting Salaries Payable", "Debiting Cash; Crediting Salaries Expense", "Debiting Salaries Expense; Crediting Cash"],
//       "answer": "Debiting Salaries Expense; Crediting Salaries Payable"
//     },
//     {
//       "question": "The purpose of the Income Summary account is to:",
//       "options": ["Record all revenues and expenses", "Facilitate the closing of temporary accounts", "Adjust permanent accounts", "Record dividends"],
//       "answer": "Facilitate the closing of temporary accounts"
//     },
//     {
//       "question": "Which of the following accounts is closed to Retained Earnings?",
//       "options": ["Revenue", "Expense", "Income Summary", "Dividends"],
//       "answer": "Income Summary"
//     },
//     {
//       "question": "The entry to close revenue accounts includes:",
//       "options": ["Debiting Revenue; Crediting Income Summary", "Debiting Income Summary; Crediting Revenue", "Debiting Retained Earnings; Crediting Revenue", "Debiting Revenue; Crediting Retained Earnings"],
//       "answer": "Debiting Revenue; Crediting Income Summary"
//     },
//     {
//       "question": "The entry to close expense accounts includes:",
//       "options": ["Debiting Expense; Crediting Income Summary", "Debiting Income Summary; Crediting Expense", "Debiting Retained Earnings; Crediting Expense", "Debiting Expense; Crediting Retained Earnings"],
//       "answer": "Debiting Income Summary; Crediting Expense"
//     },
//     {
//       "question": "The balance in the Income Summary account before it is closed represents:",
//       "options": ["Total revenues", "Total expenses", "Net income or net loss", "Dividends"],
//       "answer": "Net income or net loss"
//     },
//     {
//       "question": "The entry to close a net income to Retained Earnings includes:",
//       "options": ["Debiting Income Summary; Crediting Retained Earnings", "Debiting Retained Earnings; Crediting Income Summary", "Debiting Revenue; Crediting Income Summary", "Debiting Expenses; Crediting Income Summary"],
//       "answer": "Debiting Income Summary; Crediting Retained Earnings"
//     },
//     {
//       "question": "Which of the following is NOT a temporary account?",
//       "options": ["Revenue", "Salaries Expense", "Accumulated Depreciation", "Dividends"],
//       "answer": "Accumulated Depreciation"
//     },
//     {
//       "question": "The adjusting entry for depreciation includes:",
//       "options": ["Debiting Accumulated Depreciation; Crediting Depreciation Expense", "Debiting Depreciation Expense; Crediting Accumulated Depreciation", "Debiting Cash; Crediting Depreciation Expense", "Debiting Depreciation Expense; Crediting Cash"],
//       "answer": "Debiting Depreciation Expense; Crediting Accumulated Depreciation"
//     },
//     {
//       "question": "The purpose of adjusting entries is to ensure that:",
//       "options": ["All accounts are closed", "Financial statements are accurate", "Dividends are recorded", "Temporary accounts are reset"],
//       "answer": "Financial statements are accurate"
//     },
//     {
//       "question": "The entry to record accrued revenue includes:",
//       "options": ["Debiting Revenue; Crediting Cash", "Debiting Accounts Receivable; Crediting Revenue", "Debiting Cash; Crediting Revenue", "Debiting Revenue; Crediting Accounts Receivable"],
//       "answer": "Debiting Accounts Receivable; Crediting Revenue"
//     },
//     {
//       "question": "The final financial statements are prepared:",
//       "options": ["Before adjusting entries", "After adjusting and closing entries", "During the accounting period", "Only at the beginning of the period"],
//       "answer": "After adjusting and closing entries"
//     },
//   ],
// };
// Future<void> dataEntry() async {
//   // Reference to Firestore collection
//   final _firestore = FirebaseFirestore.instance;

//   // Creating a map where page numbers are fields
//   Map<String, dynamic> dataToStore = {};

//   for (var entry in mcqsByPage.entries) {
//     int pageNumber = entry.key;
//     List<Map<String, dynamic>> mcqs = entry.value;

//     // Store MCQs array under the page number field
//     dataToStore[pageNumber.toString()] = mcqs;
//   }

//   // Upload all pages under the 'english' document in the 'mcqs' collection
//   await _firestore
//       .collection('mcqs')
//       .doc('accounts jobs')
//       .set(dataToStore, SetOptions(merge: true));

//   print("All pages uploaded successfully.");
// }
